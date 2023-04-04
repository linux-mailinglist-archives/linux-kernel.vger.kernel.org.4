Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616B36D5BB0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjDDJSr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Apr 2023 05:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjDDJSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:18:42 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E9C1981;
        Tue,  4 Apr 2023 02:18:39 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id DA2E5FF815;
        Tue,  4 Apr 2023 09:18:35 +0000 (UTC)
Message-ID: <366ab6c4d488645aee5cbf49fb2e9b39d9bb1e22.camel@hadess.net>
Subject: Re: linux-next: build warning after merge of the hid tree
From:   Bastien Nocera <hadess@hadess.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Tue, 04 Apr 2023 11:18:35 +0200
In-Reply-To: <20230404185500.7953d9d2@canb.auug.org.au>
References: <20230404154005.449800c3@canb.auug.org.au>
         <20230404154254.6c3be26b@canb.auug.org.au>
         <e1eb90db85ed7adad08bb99054f5cda3cb626794.camel@hadess.net>
         <20230404185500.7953d9d2@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-04-04 at 18:55 +1000, Stephen Rothwell wrote:
> Hi Bastien,
> 
> On Tue, 04 Apr 2023 10:22:35 +0200 Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > On Tue, 2023-04-04 at 15:42 +1000, Stephen Rothwell wrote:
> > > 
> > > On Tue, 4 Apr 2023 15:40:05 +1000 Stephen Rothwell
> > > <sfr@canb.auug.org.au> wrote:  
> > > > 
> > > > After merging the hid tree, today's linux-next build (htmldocs)
> > > > produced
> > > > this warning:
> > > > 
> > > > drivers/usb/core/message.c:1939: warning: Function parameter or
> > > > member 'iface' not described in 'usb_set_wireless_status'
> > > > drivers/usb/core/message.c:1939: warning: Excess function
> > > > parameter
> > > > 'dev' description in 'usb_set_wireless_status'
> > > > 
> > > > Introduced by commit
> > > > 
> > > >   0a4db185f078 ("USB: core: Add API to change the
> > > > wireless_status")  
> > > 
> > > Also this:
> > > 
> > > include/linux/usb.h:270: warning: Function parameter or member
> > > 'wireless_status_work' not described in 'usb_interface'
> > 
> > How does one reproduce those warnings?
> 
> I just ran "make htmldocs" (see above).  You may need to install some
> software - but it will tell you if so.
> 

Before I send patches, does this look correct to you?

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 7930dca84616..7c7f88ca4f62 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1926,7 +1926,7 @@ static void __usb_wireless_status_intf(struct work_struct *ws)
1926⋮1926│ 
1927⋮1927│ /**
1928⋮1928│  * usb_set_wireless_status - sets the wireless_status struct member
1929⋮    │- * @dev: the device to modify
    ⋮1929│+ * @iface: the interface to modify
1930⋮1930│  * @status: the new wireless status
1931⋮1931│  *
1932⋮1932│  * Set the wireless_status struct member to the new value, and emit
diff --git a/include/linux/usb.h b/include/linux/usb.h
index a48eeec62a66..3d523ebf0c09 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -261,7 +261,8 @@ struct usb_interface {
 261⋮ 261│      unsigned needs_binding:1;       /* needs delayed unbind/rebind */
 262⋮ 262│      unsigned resetting_device:1;    /* true: bandwidth alloc after reset */
 263⋮ 263│      unsigned authorized:1;          /* used for interface authorization */
 264⋮    │-     enum usb_wireless_status wireless_status;
    ⋮ 264│+     enum usb_wireless_status wireless_status; /* whether the emitter is
    ⋮ 265│+                                                * connected to this receiver */
 265⋮ 266│      struct work_struct wireless_status_work;
 266⋮ 267│ 
 267⋮ 268│      struct device dev;              /* interface specific device info */

