Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26745712151
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbjEZHmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbjEZHmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:42:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF912C;
        Fri, 26 May 2023 00:42:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 184F064DB3;
        Fri, 26 May 2023 07:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D7CC433EF;
        Fri, 26 May 2023 07:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685086930;
        bh=4IqElaefCGYc2iZiseeUTCrdGA3ycVVXumeAANzTmpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wCQY+JmT4xxjP1TJ8Sf8ImKORqNlWlQpDLwo8MeoY1aQLbYYDLY0oHxaAmRffbyFs
         uZXsLQGpHisMJT8dxCTEIIZpoqln8X4/2IRAzSjgdTODYILvcO0Q7pA5EinulVU+Pf
         lyLmemdw3hKv6NVrocFmgOBWBgx/2Ft/ndLrPnJA=
Date:   Fri, 26 May 2023 08:42:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Roy Luo <royluo@google.com>
Cc:     raychi@google.com, badhri@google.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bastien Nocera <hadess@hadess.net>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH v1] usb: core: add sysfs entry for usb device state
Message-ID: <2023052600-survey-fondness-27ce@gregkh>
References: <20230525173818.219633-1-royluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525173818.219633-1-royluo@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 05:38:18PM +0000, Roy Luo wrote:
> + * @work: workqueue for sysfs_notify()

Do you really need this?  This should be possible to call in any context
as kernfs_notify() says that it is safe to do that, right?

Also, what userspace code is now calling poll() on your new sysfs file?

thanks,

greg k-h
