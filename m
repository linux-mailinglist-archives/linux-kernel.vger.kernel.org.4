Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D492C6DD257
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjDKGCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDKGCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:02:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C817F12B;
        Mon, 10 Apr 2023 23:02:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63D80619AB;
        Tue, 11 Apr 2023 06:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6E1C433D2;
        Tue, 11 Apr 2023 06:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681192957;
        bh=ezhQpIxcIZtBVi4dPCbFOYcDiPyeFPt+RDeVuchlMUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgZSVoxSw8gQVHsCN4BJG2P7pmPzCZpPRABVCmd40pd7deMGMif8nJuOtK8QETQST
         CsvtFMwU7i+zOoSvkLA4Ba7ZFkZdz4DqgvCRuFSI3A4ROUQU8K+Dt9qEEIJYN85F/8
         8MnocOAD+cySS1Zmf/1pO/fA871RUCq4sZgn57vo=
Date:   Tue, 11 Apr 2023 08:02:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation: firmware: Clarify firmware path usage
Message-ID: <ZDT39frTIqpX5p9O@kroah.com>
References: <20230402135423.3235-1-f.fainelli@gmail.com>
 <87y1mzcq9y.fsf@meer.lwn.net>
 <1f4b874b-bd1e-17ff-51dd-19bf2d73214f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f4b874b-bd1e-17ff-51dd-19bf2d73214f@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 04:12:32PM -0700, Florian Fainelli wrote:
> 
> 
> On 4/10/2023 3:43 PM, Jonathan Corbet wrote:
> > Florian Fainelli <f.fainelli@gmail.com> writes:
> > 
> > > Newline characters will be taken into account for the firmware search
> > > path parameter, warn users about that and provide an example using 'echo
> > > -n' such that it clarifies the typical use of that parameter.
> > > 
> > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > ---
> > >   Documentation/driver-api/firmware/fw_search_path.rst | 9 +++++++--
> > >   1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/driver-api/firmware/fw_search_path.rst b/Documentation/driver-api/firmware/fw_search_path.rst
> > > index a360f1009fa3..d7cb1e8f0076 100644
> > > --- a/Documentation/driver-api/firmware/fw_search_path.rst
> > > +++ b/Documentation/driver-api/firmware/fw_search_path.rst
> > > @@ -22,5 +22,10 @@ can use the file:
> > >   * /sys/module/firmware_class/parameters/path
> > > -You would echo into it your custom path and firmware requested will be
> > > -searched for there first.
> > > +You would echo into it your custom path and firmware requested will be searched
> > > +for there first. Be aware that newline characters will be taken into account
> > > +and may not produce the intended effects. For instance you might want to use:
> > > +
> > > +echo -n /path/to/script > /sys/module/firmware_class/parameters/path
> > > +
> > > +to ensure that your script is being used.
> > 
> > So I have no problem with applying this, but I have to ask...might it
> > not be better to fix the implementation of that sysfs file to strip
> > surrounding whitespace from the provided path?  This patch has the look
> > of a lesson learned the hard way; rather than codifying this behavior
> > into a feature, perhaps we could just make the next person's life a bit
> > easier...?
> 
> I was not sure whether it was on purpose or not, Greg, will we break
> anyone's use case if we strip off \n from the firmware path passed via
> sysfs?

I do not know, sorry.
