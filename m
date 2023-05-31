Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06FD717A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjEaInR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjEaInP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:43:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6678ABE;
        Wed, 31 May 2023 01:43:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01DA363834;
        Wed, 31 May 2023 08:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548D3C433EF;
        Wed, 31 May 2023 08:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685522593;
        bh=s4t+Z4bQTlyFJ05G5k3BJkFvhBy3z6GR9euUFM8vS+8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dmKSoM0FNyamDabmjd+4lt6NXDgd8/pkAFJcTaWxSfRgBp9CRN903J+Oqkt7M3ZaT
         NEBF48UN6cT6A6kMOSnYjUIciotz3JovgCsqv2N8F8cFRmkuhf3MU8A0/DQZ9r1WLB
         uRy69iYzC2hrGqX6WsQGtOi7kS/He+mo2o7pfEabX7jO7bDElxOnMRTmDicGMl/ZY/
         twX1TAF7IezoVYDCz2re4IAeFaYJMR+XgP92T6DPOzZwEj8DxixPiYBK7aLtUjZgeX
         2a5lFEGlUSUAVBnMmxr1/bTuf2XoZhvJ0Mc9txxnRiQ7Pzn9tirpEQvl8dWhlEllx0
         xnDBNn43qPRZg==
Date:   Wed, 31 May 2023 10:43:08 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, guy.b@bluewin.ch
Subject: Re: [regression] Since kernel 6.3.1 logitech unify receiver not
 working properly
In-Reply-To: <746720e5-318c-6d9e-2d5a-a6ebf6b4b0c6@leemhuis.info>
Message-ID: <nycvar.YFH.7.76.2305311042150.29760@cbobk.fhfr.pm>
References: <9b987585-0834-bb8c-3414-283c29f3f2ab@leemhuis.info> <bec024d5-4088-00ae-f7b5-7188868b1707@leemhuis.info> <b7717c43-74bf-b91d-d3ce-874493df602c@gmail.com> <CAO-hwJ+At1J_yUpX2q_dJekzZ-PoTDAvxmkTk_e4Yu0Z338bEA@mail.gmail.com>
 <55dda0bb-fe42-6dee-28ea-00121554d092@leemhuis.info> <CAHk-=whvhkSk6m8_AidhofgR9nq0Md+HbNad5r1RE69tZgbv6Q@mail.gmail.com> <nycvar.YFH.7.76.2305231422180.29760@cbobk.fhfr.pm> <CAO-hwJ+MTRu9KxqwQc7UYFBsa0kkrnYfwVB30KsLZnw=wfcOMg@mail.gmail.com>
 <nycvar.YFH.7.76.2305251308471.29760@cbobk.fhfr.pm> <nycvar.YFH.7.76.2305262040330.29760@cbobk.fhfr.pm> <746720e5-318c-6d9e-2d5a-a6ebf6b4b0c6@leemhuis.info>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2023, Thorsten Leemhuis wrote:

> > who is able to reproduce the issue please check whether 
> > reverting
> > 
> > 	586e8fede7953b16 ("HID: logitech-hidpp: Retry commands when device is busy")
> > 
> > has any observable effect?
> 
> See https://bugzilla.kernel.org/show_bug.cgi?id=217412#c26 and later –
> it at least solved the problem for one user.
> 
> But it's all a mess (at least afaics). Earlier in that ticket some other
> user said things work with 6.4-rc kernel, while for another confirmed
> things are still broken. So maybe we deal with more than one problem. Or
> testing went sideways for some of the users.

The patch that needs to be tested now by the affected users is here:

	https://patchwork.kernel.org/project/linux-input/patch/20230531082428.21763-1-hadess@hadess.net/

-- 
Jiri Kosina
SUSE Labs

