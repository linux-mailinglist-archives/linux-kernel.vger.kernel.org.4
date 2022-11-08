Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6BC621D00
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKHT2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKHT2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:28:44 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708F7193F8;
        Tue,  8 Nov 2022 11:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1667935713;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XAL3s5j75Kq2jhzOQEusmr7a0Cgo2qohGoilcfq/xf4=;
    b=cHbVnCCXWcwfxWCZlcbKF7m6KfX+30BGIYu6AlrzTHjHMRV7PKTJppFo9ZgCEfblhO
    C3NFauFyawmgV8mwoD6BUaYnwAb2Z2eAHf+GUv8lghmCk7jvzVmJ8jCxd26GLSqPQW5V
    I5f/zSy4AeLk4kbwfnnqVK2KKJgRPdnu3iaJejnyFxwIDPhp0zeSA/AxOmnnD2HuhZyS
    2rT8O4VQQibM7y8aYLMyxYTEkhAIXlQ+zkA0KMCAvLYXrd3Ui9+y0pV7Rz1E2Y+b48vB
    LoiNxyxA/V+CvwyGvcaQl73RQsY/7fV5mq7p3PlX7Ca0S4XKep6rTRd9vh4RRBMW3Pop
    tkSg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
X-RZG-CLASS-ID: mo00
Received: from blinux
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyA8JSUpIh
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 8 Nov 2022 20:28:30 +0100 (CET)
Message-ID: <fa3905bff8ba47b0ed45f9221dd1d033ca553179.camel@iokpp.de>
Subject: Re: [RFC PATCH v1 2/2] ufs: core: Add advanced RPMB support in
 ufs_bsg
From:   Bean Huo <beanhuo@iokpp.de>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "hare@suse.de" <hare@suse.de>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Nov 2022 20:28:29 +0100
In-Reply-To: <DM6PR04MB657518129522996B2B5C9640FC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221107131038.201724-1-beanhuo@iokpp.de>
         <20221107131038.201724-3-beanhuo@iokpp.de>
         <DM6PR04MB657518129522996B2B5C9640FC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avri, 
thanks for your comments and review.


On Tue, 2022-11-08 at 19:09 +0000, Avri Altman wrote:
> > Add advanced RPMB support in ufs_bsg. For these reasons, we try to
> > implement Advanced RPMB in ufs_bsg:
> > 1. According to the UFS specification, only one RPMB operation can
> > be
> > performed at any time. We can ensure this by using reserved slot
> > and its
> > dev_cmd sync operation protection mechanism.
> 
> Regardless of its technical convenience, this approach unfortunately
> breaks the spec.
> 
> The spec say (please note the line numbers):
> 
> ".....
> 
> 5197 12.4.5.1 Advanced RPMB Message
> 
> 5198 An Advanced RPMB Message is composed of an Advanced RPMB Meta
> Information and a MAC/KEY in
> 
> 5199 the EHS field in *COMMAND UPIU* and *RESPONSE UPIU*. Advanced
> RPMB Data is delivered through
> 
> ....."

> Moreover, in the examples that are provided, it is still expected to
> be carried via SECURITY PROTOCOL IN and SECURITY PROTOCOL OUT,
> 
> See e.g. Figure 12.15 — Authenticated Data Write Flow (in Advanced
> RPMB Mode).
> 
> 
not quite get what you meant here.
> 

> 
> Therefore, wrapping the rpmb packets in a query-request upiu and
> query-response upiu is not allowed.
> 
> 

no, I didn't wrap RPMB packet in query-request/response, it is inupiu_req and upiu_rsp, it is upiu command. Based on Bart's suggestion,
we shouldn't change the current ufs_bsg structure. I think his concern
is that if we change ufs_bsg structure, the user space tool also
needs to change as well. 

> 
> Still, I agree that the approach you suggested, namely to rely on the
> ufs-bsg driver, is the cleanest way to handle the advance rpmb
> access.
> 
> However, IMHO, you need to do it is by adding command UPIU to the
> ufs-bsg driver.
> 
> 

Yes, agree with you on this point. But we still need to use reserved
slots for RPMB or command UPIU, we don't want to affect IO requests on
the normal path.

One problem is that we didn't split the dev_manage command and the RPMB
command in their completion handlers. I would like to change dev_man to
passthrough or something else, and then split dev_man and RPMB,
otherwise, they would be mixed in one dev_man completion handler. No
technical issues here, just want to make it more readable and
maintainable.



Kind regards,
Bean

> 
> Thanks,
> 
> Avri

