Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CDA701CEC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 12:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjENK7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 06:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjENK7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 06:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8C8198D;
        Sun, 14 May 2023 03:59:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D2AC60FEB;
        Sun, 14 May 2023 10:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DD5C433D2;
        Sun, 14 May 2023 10:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684061978;
        bh=fWwZ3vYa6O/Gb+7Owes2wmBd6NQXiz+nV9ckH3UmStA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sArBdor0LgFtCo6uSy4nn3aGdO7S4R9LqZ5Eb5/JefMe6iT6w69kJsNs2JZr4XSDR
         d3xqQ7SPIdOquKQ1W3MpwW1lZKnm50olquy8dvy0+qdkQVokt6G3wKlKPaS9AR0gew
         zbSfNyYSDSw+MsH4weVkTeIP8L0FOOs8uXjuxroTBcpzy60gh7USQUcbmBdHFj1kU+
         qENFtYfp9uvcVhYhUnOGPm4Zi9CEgEYTyb22opnxd/pb4+yWxe3h7i4/2UtaHu7Khz
         Eyw8FDpmh0di3VC2b7qZRIH7ReCbjZ8qgNVnMh0cXo2w1+50u13sr2tgwAs1hRbmnv
         UUygWa3SWkJ2w==
Message-ID: <55d5ec29-f30f-4596-a3b9-7e5b8adf0582@kernel.org>
Date:   Sun, 14 May 2023 12:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: mainline build failure due to cf21f328fcaf ("media: nxp: Add
 i.MX8 ISI driver")
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
References: <ZElaVmxDsOkZj2DK@debian>
 <51cff63a-3a04-acf5-8264-bb19b0bee8a3@leemhuis.info>
 <CAHk-=wgzU8_dGn0Yg+DyX7ammTkDUCyEJ4C=NvnHRhxKWC7Wpw@mail.gmail.com>
 <20230510090527.25e26127@sal.lan>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230510090527.25e26127@sal.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 10:05, Mauro Carvalho Chehab wrote:
> And another CI job testing bisect breakages as I receive pull requests,
> applying patch per patch and using both allyesconfig and allmodconfig,
> also on x86_64 arch with W=1:
> 
> 	https://builder.linuxtv.org/job/patchwork/
> 
> The rule is to not merge stuff on media tree if any of those jobs
> fail. I also fast-forward merging patches whose subject states that
> the build has failed.
> 
> In order to help with that, on normal situation, I usually take one week
> to merge stuff from media_stage into media_tree, doing rebases at
> media_stage if needed to avoid git bisect build breakages at media_tree
> (which is from where I send my update PRs to you).
> 
> Unfortunately, currently we don't have resources to do multiple randconfig

Hi Mauro,

Is you media staging tree included in LKP (kernel test robot)? You would
get huge build coverage after every push to your staging repo.

Except of maintainer trees, it is also useful to add there development
trees. That way for 'free' I can get early warnings about all my patches.

Best regards,
Krzysztof

