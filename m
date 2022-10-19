Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C68C604B35
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiJSPYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiJSPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:23:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8268F6C3C;
        Wed, 19 Oct 2022 08:17:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0383B6192A;
        Wed, 19 Oct 2022 15:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A4DC433D6;
        Wed, 19 Oct 2022 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666192621;
        bh=emdSBMANCR6uNMgdrWui26CerAZMz0PO1mE8mf8K38I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NtIj5AaIJMQsoLDLshvbXse+vgPR9uUxazvQLqpajUFiEsaNXtiVlfdasyAicc5aI
         pYoDam4WJeXG+x+zKgxRRnTD1l4cHgEwSY0AhU6Pz6MwQ1eCCG457+VdQTtqqOrNQ2
         RU53lyEjQhbCiVYl73IlDkm6fmiM+/4aqRIybg10V2AezXadIy+0zbs6PWagl6J3JZ
         kGPlEYUQh6hLKwWoVi+ND6QFoYNs7Mu2plmuFXBNiAy9DRmsWeMCPuiYzoRQItSOd+
         H0bQIU2MP6hihlOoCUI5KfDC+7YOuduj+9i1zPgfR0C+X+8ffZ825BDa6OwzWkpn23
         zSL82ii3pZjbQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CF6E840B44; Wed, 19 Oct 2022 12:16:58 -0300 (-03)
Date:   Wed, 19 Oct 2022 12:16:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Carsten Haitzler <carsten.haitzler@foss.arm.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 02/13] perf test: Add build infra for perf test tools
 for CoreSight tests
Message-ID: <Y1AU6qUGUVJB1KSX@kernel.org>
References: <20220909152803.2317006-3-carsten.haitzler@foss.arm.com>
 <Yz67SHpIN5NggKEk@kernel.org>
 <Yz6/zlchVnNsVlzJ@kernel.org>
 <Yz7RAgMN6WGnD3OZ@leoy-yangtze.lan>
 <e9f980a7-fba8-4610-a058-b74e51d6ab24@foss.arm.com>
 <Y0AfK7sVphNkQA4q@kernel.org>
 <0b3afc5d-c4a1-8a50-45c3-20c706c3ecfd@foss.arm.com>
 <Y0QkIjO4pvPuzeMB@kernel.org>
 <9f2d2032-8859-4388-489a-ba5cd2cee432@foss.arm.com>
 <Y0+6jbL1oC4jk8Ja@leoy-huanghe.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0+6jbL1oC4jk8Ja@leoy-huanghe.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 19, 2022 at 04:51:25PM +0800, Leo Yan escreveu:
> On Wed, Oct 19, 2022 at 09:11:20AM +0100, Carsten Haitzler wrote:
> > 
> > 
> > On 10/10/22 14:54, Arnaldo Carvalho de Melo wrote:
> > > Em Mon, Oct 10, 2022 at 08:02:29AM +0100, Carsten Haitzler escreveu:
> > > > On 10/7/22 13:44, Arnaldo Carvalho de Melo wrote:
> > > > > Em Fri, Oct 07, 2022 at 12:34:51PM +0100, Carsten Haitzler escreveu:
> > > > > > On 10/6/22 13:58, Leo Yan wrote:
> > > > > > oh sorry - indeed i didn't see this problem coming after fixing the
> > > > > > conflicts. i've got an update of the patches that fix that. should i just
> > > > > > send through the 2 updates patches as a v10 or the whole series?
> > > 
> > > > > No need, I did some fixes taking into account the comments on this
> > > > > thread, we can go on and fix things from what I have now at
> > > > > acme/perf/core, which I'll send to Linus today.
> > > > oh cool. i'll let patches sit for now - let me know if there's anything you
> > > > want/need from me.
> > > 
> > > Not right now, I'm now just waiting for Linus to merge what I sent, then
> > > you can continue from upstream.
> > 
> > I'm not sure what you have sent to Linus? The patch series? Specific
> > patches?
> 
> I think the whole patch set has been merged into Linux mainline;
> after git pull the Linux mainline code and you could see:
> 
> $ git log --oneline --author="Carsten Haitzle"
> dc2e0fb00bb2 perf test coresight: Add relevant documentation about ARM64 CoreSight testing
> 43c688cb3241 perf test: Add git ignore for tmp and output files of ARM CoreSight tests
> b65c6477f6bb perf test coresight: Add unroll thread test shell script
> fc0a0ea03980 perf test coresight: Add unroll thread test tool
> 74c62b8d6161 perf test coresight: Add thread loop test shell scripts
> e9664b96c6c0 perf test coresight: Add thread loop test tool
> b76692fea7f2 perf test coresight: Add memcpy thread test shell script
> f1288bdb6d48 perf test coresight: Add memcpy thread test tool
> 6ea586b1e3dc perf test: Add git ignore for perf data generated by the ARM CoreSight tests
> fdc25cc59c71 perf test: Add arm64 asm pureloop test shell script
> 8b97519711c3 perf test: Add asm pureloop test tool
> 34bec35cbbb2 perf test: Add build infra for perf test tools for ARM CoreSight tests
> c63317ab14b0 perf test: Add CoreSight shell lib shared code for future tests
> 7391db645938 perf test: Refactor shell tests allowing subdirs

Thanks, Leo, Carsten, are we on the same page now? :-)

- Arnaldo
