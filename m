Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C2C6872DE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjBBBPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBBBPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:15:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA61125A4;
        Wed,  1 Feb 2023 17:15:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49E3E619A5;
        Thu,  2 Feb 2023 01:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8860DC433EF;
        Thu,  2 Feb 2023 01:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675300511;
        bh=N/pM1QoS7vJEdspk7E7qTGGQVYnXc5TDwFG3QmUqoVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlVtRVzA12yvuCrAJ6ErT5eosoYQ+vqqaDNbJ4XOcGJRjtnYZxpGGnWFQYeU6nxvs
         xHOVvZF1bjg24bPrcJre+nQzd34dH7lh4pF94ScUeAzksGJU4BjlRrogjEq7kGuF0+
         +JcKFmrojlU9naYv7mgmMK6HzimvMIvsvZeBebF0jnrYX3bSQHpKEkURZdTiK7bQt8
         Npi6qWEby+Sy+0PuPaanLJSPp3P1LqLmU9Nlut83KQL1NM8gnoSwwk7y8xRmjym4vo
         azOkC1DDpnAL/jq8pkJHuZ/1oghA74lteCtrhv65GtzlFqRwCKyWynbSXkz1wm2ttK
         4lQf5WXvFUeVQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4E44A405BE; Wed,  1 Feb 2023 22:15:09 -0300 (-03)
Date:   Wed, 1 Feb 2023 22:15:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Add raw decoding for SPEv1.2 previous
 branch address
Message-ID: <Y9sOndEjyy1IQ0gR@kernel.org>
References: <20230127205951.673253-1-robh@kernel.org>
 <Y9cm6sLGTA6hZrIu@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9cm6sLGTA6hZrIu@leoy-yangtze.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 30, 2023 at 10:09:46AM +0800, Leo Yan escreveu:
> On Fri, Jan 27, 2023 at 02:59:51PM -0600, Rob Herring wrote:
> > Arm SPEv1.2 adds a new optional address packet type: previous branch
> > target. The recorded address is the target virtual address of the most
> > recently taken branch in program order.
> > 
> > Add support for decoding the address packet in raw dumps.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 4 +++-
> >  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 1 +
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index 2f311189c6e8..e92e1a7c8a8e 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > @@ -422,16 +422,18 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
> >  	int ch, pat;
> >  	u64 payload = packet->payload;
> >  	int err = 0;
> > +	static const char *idx_name[] = {"PC", "TGT", "VA", "PA", "LBR" };
> 
> I know you use the "LBR" which is a naming convention from X86 arch,
> Armv8 ARM defines the name "PBT", so "PBT" would be easier for us to
> match code with architecture specification.
> 
> "LBR" is also fine for me, it's up to you if you want to update for
> this:

Waiting for a response to this.

- Arnaldo
 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
> 
> >  	switch (idx) {
> >  	case SPE_ADDR_PKT_HDR_INDEX_INS:
> >  	case SPE_ADDR_PKT_HDR_INDEX_BRANCH:
> > +	case SPE_ADDR_PKT_HDR_INDEX_PREV_BRANCH:
> >  		ns = !!SPE_ADDR_PKT_GET_NS(payload);
> >  		el = SPE_ADDR_PKT_GET_EL(payload);
> >  		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
> >  		arm_spe_pkt_out_string(&err, &buf, &buf_len,
> >  				"%s 0x%llx el%d ns=%d",
> > -				(idx == 1) ? "TGT" : "PC", payload, el, ns);
> > +				idx_name[idx], payload, el, ns);
> >  		break;
> >  	case SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT:
> >  		arm_spe_pkt_out_string(&err, &buf, &buf_len,
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > index 9b970e7bf1e2..f75ed3a8a050 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > @@ -65,6 +65,7 @@ struct arm_spe_pkt {
> >  #define SPE_ADDR_PKT_HDR_INDEX_BRANCH		0x1
> >  #define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	0x2
> >  #define SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS	0x3
> > +#define SPE_ADDR_PKT_HDR_INDEX_PREV_BRANCH	0x4
> >  
> >  /* Address packet payload */
> >  #define SPE_ADDR_PKT_ADDR_BYTE7_SHIFT		56
> > -- 
> > 2.39.0
> > 

-- 

- Arnaldo
