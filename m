Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D426ED8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 01:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjDXXwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 19:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDXXwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 19:52:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D358540CE;
        Mon, 24 Apr 2023 16:52:06 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 24F744FE;
        Tue, 25 Apr 2023 01:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1682380313;
        bh=ZWEtx4Bjs4d2RnT/vCDDwVjnGGS1E/KfYT7SkdcrGH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sTMGDcQcDfq+KZhgthulPS7fIdrwoOGPmHaZvZUjDaPzT9KOVYg6cjyfyhHX+OIRg
         4h1kLYJ5KO9p2lPJiar8BuZnaZHP0ft7duAyBlvZvIuY1rrIGOpupoD+bfNDUPwgV6
         XAF0sittplyLZO37wRWk4b48KknR0lUnTuk4Yyc0=
Date:   Tue, 25 Apr 2023 02:52:14 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] media: renesas: fdp1: remove R-Car H3 ES1.*
 handling
Message-ID: <20230424235214.GE6316@pendragon.ideasonboard.com>
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
 <20230307163041.3815-6-wsa+renesas@sang-engineering.com>
 <CAMuHMdVQiMbupkCYhZ86WHND25E==iA1DyVwGf2rg32zJLcV2g@mail.gmail.com>
 <ZEbVyhjKs15Rj+5h@sai>
 <CAMuHMdW9F4adqsWj7BpvTSGMamPdM-OM+oY_nM0-xTMnuaFr-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW9F4adqsWj7BpvTSGMamPdM-OM+oY_nM0-xTMnuaFr-A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 09:37:00PM +0200, Geert Uytterhoeven wrote:
> On Mon, Apr 24, 2023 at 9:17 PM Wolfram Sang wrote:
> > > > -#define FD1_IP_H3_ES1                  0x02010101
> >
> > ...
> >
> > > Apparently 0x02010101 is also used on (at least) R-Car M2-W ES1.0,
> > > causing the following annoying (but further harmless?) messages
> > > during boot:
> > >
> > >     rcar_fdp1 fe940000.fdp1: FDP1 Unidentifiable (0x02010101)
> > >     rcar_fdp1 fe944000.fdp1: FDP1 Unidentifiable (0x02010101)
> >
> > Hmm, that means before my removal patch, Gen2 has been incorrectly
> > defined as H3 ES1?
> 
> Indeed, but the driver doesn't seem to do anything with the detected
> version, except for printing a debug or error message.

It may not now, but I'd rather get this fixes nonetheless to avoid
forgetting about the issue and wondering later once we take the version
into account why M2-W doesn't work.

> > > Note that the R-Car Gen2 documentation states the register's contents
> > > are all zeroes.  But that value would trigger the error message, too.
> >
> > Bad, but well...
> >
> > > Sorry for not noticing before. Apparently I never booted a kernel
> > > with this patch on koelsch...
> >
> > We could re-add this version and just let it print "FDP1 Initial
> > Version" or something? I could test this on my Lager board.
> 
> I plan to test it on a few other boards, too...
> Just wanted to let you know ASAP...

-- 
Regards,

Laurent Pinchart
