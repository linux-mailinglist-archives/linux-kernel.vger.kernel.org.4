Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD3D6428F3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiLENIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiLENIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:08:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D60C50
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:08:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12551B8103C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D284C433D6;
        Mon,  5 Dec 2022 13:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670245682;
        bh=rz0aQMRhLu0Pg/KFjnJmpIGy9ZGmakq/tG0M01anpTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oLDLuM0LPrLccClpNmaSARtVvKSxsGOcxrP1U/CJVj/8WipW5vBDMVSMsCxvvbfq7
         DYnlLWrb2HaqSW93Tv09VWwo23emNnQWefJS/ZRyyOTu5N3WueomX+XIXABX8n7shy
         nKWxr293S1bPWZ0A8VAHjPoGqd5H1V6ea+78WxMPWONZE9zNJ/EEQuzZElUg8bLWaq
         5g4ti1xgyMEaQ3UYy5BRHp+xQGg3uOft8fLdYzqrAtOfR07EcNTqdvPbI/r5APZpnq
         y4BYFhe8Va4sBefJFk6ovUqHpikMSsgLK+AhQAywag9IhUUCKJ5picP0ZfDRIRZCsD
         stQ+u2ImdzNPw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 152ED40404; Mon,  5 Dec 2022 10:08:00 -0300 (-03)
Date:   Mon, 5 Dec 2022 10:08:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tmp.perf/core segfaulting on metrics test
Message-ID: <Y43tMP63JSnZ56vc@kernel.org>
References: <Y4pN9MbSuANbn68W@kernel.org>
 <CAM9d7ch7EkOhQGSXZDzbhdGTP_4L243Kyt3FrT6Nv3Rgx-xKtg@mail.gmail.com>
 <CAM9d7ciq+FDoELa-RqYi+hyxZEqD4ucUEtCpoZWzNidQ4=OAUA@mail.gmail.com>
 <Y43suxmKgxyrag+L@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y43suxmKgxyrag+L@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 05, 2022 at 10:06:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Dec 02, 2022 at 11:38:28AM -0800, Namhyung Kim escreveu:
> > On Fri, Dec 2, 2022 at 11:33 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hi Arnaldo,
> > >
> > > On Fri, Dec 2, 2022 at 11:11 AM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > While trying to get back at processing patches for Linux 6.2, what I
> > > > have at tmp.perf/core branch is failing like below, can someone try to
> > > > help in diagnosing this?
> > >
> > > I think you missed this
> > >
> > >   https://lore.kernel.org/r/20221130111521.334152-2-james.clark@arm.com
> 
> Yeah, applied now.
  
> > Or, it could be something reported by Ian.
> > 
> >   https://lore.kernel.org/CAP-5=fUOjSM5HajU9TCD6prY39LbX4OQbkEbtKPPGRBPBN=_VQ@mail.gmail.com
> 
> Ditto, with a separate patch.
> 
> Thanks!
> 
> - Arnaldo

-- 

- Arnaldo
