Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55D55F9FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiJJNyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJJNys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:54:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C87CE36;
        Mon, 10 Oct 2022 06:54:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1854E60F5E;
        Mon, 10 Oct 2022 13:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C212C433C1;
        Mon, 10 Oct 2022 13:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665410085;
        bh=XrcN3iuKei+dF8KsfhLx+HbbjgjNclIPzqcHPB0qUX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJan9Qq/0mIMAdxo0+hFMn2TOc+2W1FoZEJX5LebHM+BylOh9m3OKmweAuEOxANa/
         QQ1QPkZLLswReQhwA5aK1BnxDnH7kvuPF4X6coEXzuLJqG3M3tmhn+koeQB4DdjoNh
         lXZ2cZHby/2RQVGsRQ7uxNKC6uSVLknidjkjE7e4eBD76pM2Jbsnl/IezeQat0F2j1
         jZVMnxI7uC3MK3kcBbvy7TvCw7msG6CkkeehCkoAGZ2eC3ro9tZ/leZ9aMNxgWURkI
         cbVrDuwyFFokPMc9Kunw7uuJShVnoDdoIBdScowi8ZhXMcE5VLptU0HIboPVB5O3d4
         Xyo4Kd1C6Lu9w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 274274062C; Mon, 10 Oct 2022 10:54:42 -0300 (-03)
Date:   Mon, 10 Oct 2022 10:54:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Carsten Haitzler <carsten.haitzler@foss.arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 02/13] perf test: Add build infra for perf test tools
 for CoreSight tests
Message-ID: <Y0QkIjO4pvPuzeMB@kernel.org>
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
 <20220909152803.2317006-3-carsten.haitzler@foss.arm.com>
 <Yz67SHpIN5NggKEk@kernel.org>
 <Yz6/zlchVnNsVlzJ@kernel.org>
 <Yz7RAgMN6WGnD3OZ@leoy-yangtze.lan>
 <e9f980a7-fba8-4610-a058-b74e51d6ab24@foss.arm.com>
 <Y0AfK7sVphNkQA4q@kernel.org>
 <0b3afc5d-c4a1-8a50-45c3-20c706c3ecfd@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b3afc5d-c4a1-8a50-45c3-20c706c3ecfd@foss.arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 10, 2022 at 08:02:29AM +0100, Carsten Haitzler escreveu:
> On 10/7/22 13:44, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Oct 07, 2022 at 12:34:51PM +0100, Carsten Haitzler escreveu:
> > > On 10/6/22 13:58, Leo Yan wrote:
> > > oh sorry - indeed i didn't see this problem coming after fixing the
> > > conflicts. i've got an update of the patches that fix that. should i just
> > > send through the 2 updates patches as a v10 or the whole series?

> > No need, I did some fixes taking into account the comments on this
> > thread, we can go on and fix things from what I have now at
> > acme/perf/core, which I'll send to Linus today.
 
> oh cool. i'll let patches sit for now - let me know if there's anything you
> want/need from me.

Not right now, I'm now just waiting for Linus to merge what I sent, then
you can continue from upstream.

- Arnaldo
