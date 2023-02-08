Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2940168F29C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjBHP5A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Feb 2023 10:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjBHP4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:56:51 -0500
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A7B48A08
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 07:56:21 -0800 (PST)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 6A872160E9C;
        Wed,  8 Feb 2023 15:56:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id E6E608000E;
        Wed,  8 Feb 2023 15:56:04 +0000 (UTC)
Message-ID: <38b6c1a63909a1ce207e26deaf212588a83dd0ff.camel@perches.com>
Subject: Re: [PATCH 02/10] staging: rtl8192e: Calculate definition of
 MSR_LINK_MASK
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Wed, 08 Feb 2023 07:56:03 -0800
In-Reply-To: <Y+OWFsZD3m+VsnYS@kroah.com>
References: <cover.1675792435.git.philipp.g.hortmann@gmail.com>
         <8c8a126a83683bae69d0fd20a93bdea8f810f6d0.1675792435.git.philipp.g.hortmann@gmail.com>
         <Y+OWFsZD3m+VsnYS@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: E6E608000E
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Server: rspamout01
X-Stat-Signature: sdz1zomcpn663nbbfi9ptcuis5y6yeda
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/fSsBryfjjaGUCa+HpXN59kaiPfLrMA/s=
X-HE-Tag: 1675871764-307607
X-HE-Meta: U2FsdGVkX19tK0JYzcNwivO0LT+dSMogUTn/ODefw6fPABfzdAQqTLjLy3nQRhkmwLg0kbH+wSLVkLHrxegk9A==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-02-08 at 13:31 +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 07, 2023 at 07:16:22PM +0100, Philipp Hortmann wrote:
> > Calculate definition of MSR_LINK_MASK ((1<<0)|(1<<1)) = 3. Equation is not
> > accepted by checkpatch because of missing spaces.
[]
> > diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
[]
> > @@ -170,7 +170,7 @@ enum _RTL8192PCI_HW {
> >  #define	BW_OPMODE_20MHZ			BIT2
> >  	IC_VERRSION		= 0x301,
> >  	MSR			= 0x303,
> > -#define MSR_LINK_MASK      ((1<<0)|(1<<1))
> > +#define MSR_LINK_MASK      3
> 
> This is a bit field, it should be:
> 	#define MSR_LINK_MASK	(BIT(1) | BIT(0))
> right?

Perhaps better as GENMASK(1, 0)

