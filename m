Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67FA693A37
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 22:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBLVN3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 12 Feb 2023 16:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjBLVN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 16:13:27 -0500
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E32D1043E;
        Sun, 12 Feb 2023 13:13:24 -0800 (PST)
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 174AA140441;
        Sun, 12 Feb 2023 21:13:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 6317920016;
        Sun, 12 Feb 2023 21:13:20 +0000 (UTC)
Message-ID: <b82c782ee8c789a0bdc702526fd993952cabb6a2.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: add email addresses from dts files
From:   Joe Perches <joe@perches.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sun, 12 Feb 2023 13:13:19 -0800
In-Reply-To: <0d1f5d23-7a91-eee9-c7fe-044db8869735@linaro.org>
References: <20230211121441.64359-1-krzysztof.kozlowski@linaro.org>
         <6b9347bc16febf724ca33fe99597eb163b4254ff.camel@perches.com>
         <0d1f5d23-7a91-eee9-c7fe-044db8869735@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: 85drdbu11d9ri3kc5zddytr3o6zknps9
X-Rspamd-Server: rspamout06
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Queue-Id: 6317920016
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/mtyatMvdED3hyezBVZribRqNFiLZ/Jek=
X-HE-Tag: 1676236400-339113
X-HE-Meta: U2FsdGVkX1/5Zyzffp8AoqaHdodtalmQg+EYOIzEDxzEWcZ1mb6H852oXy66R0EQUWfmzIjMk/P3KxMyYTicAw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-02-12 at 16:51 +0100, Krzysztof Kozlowski wrote:
> On 11/02/2023 17:27, Joe Perches wrote:
> > On Sat, 2023-02-11 at 13:14 +0100, Krzysztof Kozlowski wrote:
> > > The DTS/DTSI files represent hardware description for Linux kernel,
> > > which is necessary to properly recognize and configure hardware by
> > > Linux.  DTS is usually created by people having the actual hardware and
> > > having interest in keeping it in good shape.  Such people can provide
> > > review (they might have board schematics) and testing.  Unfortunately
> > > they mostly do not appear in MAINTAINERS file.  Adding per-DTS entries
> > > to MAINTAINERS would quickly make it bloated (hundreds of new per-DTS
> > > entries).
> > > 
> > > On the other hand there is no point in CC-ing every Copyright email
> > > appearing in files, because it might be outdated.

That's what .mailmap is for.

> > > Add new in-file
> > > pattern for storing maintainers dedicated to specific boards:

I think adding Maintainer: who <who@foo.tld>

to each dts and dtsi file would be a lot of unnecessary changes
$ git ls-files | grep -P '\.dtsi?$' | wc -l
4673

> > > This is rework of earlier approach:
> > > Link: https://lore.kernel.org/r/20210809080204.8381-1-shawnguo@kernel.org
> > 
> > Why the rework?  I think the older one is much simpler.
> > 
> > I believe I forwarded the older one to Andrew Morton awhile back.
> > I'll check to see what happened to it.
> 
> It was never merged, thus I assumed some changes are needed, e.g. to
> ignore emails in copyrights.

I think the old one is fine.
