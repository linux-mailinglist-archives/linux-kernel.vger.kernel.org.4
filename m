Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A26675BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjATRsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjATRsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:48:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAE2F76E;
        Fri, 20 Jan 2023 09:47:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8681F6203A;
        Fri, 20 Jan 2023 17:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23C0C433EF;
        Fri, 20 Jan 2023 17:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674236878;
        bh=jekznAemlinI9fSN2j3OXrmRYwz4z6tzRDT1A/Ec7X4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gdRX39L91h8uY/H5Xz2dC6fngxZP09+e1GDHj/zldfkoVr8Fvo9zuV+pXP37Fanne
         i+o1PwulUUzLKJcDmLtHK8gd+8foF+QEi68lmYH2oFLva26UEQh80x5eE0rW0gORyv
         ujZbyUv3tdGBJ+b7ZQ8nUCGViyB8ZcF1xOV2FPgWhBzGQRiUWOSpqAHdy7Io1Z1dv3
         2hf/bmXtY3xASngDw20kRmdmE6zE4m36Sim0GtigcPu37bnNF+krn15TVZmAwPRhDN
         EcdGGH+bi/o9k5L2cA4b4kSPY8rJaM40TdaEfJfg517lklUnHvM1ZhOVevXx6EFF/C
         pbRtQ7g+VR+vg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B0462405BE; Fri, 20 Jan 2023 14:47:55 -0300 (-03)
Date:   Fri, 20 Jan 2023 14:47:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tanmay Jagdale <tanmay@marvell.com>
Cc:     James Clark <james.clark@arm.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>
Subject: Re: [PATCH v3 0/7] perf cs_etm: Basic support for virtual/kernel
 timestamps
Message-ID: <Y8rTyzfQaO8S8S/v@kernel.org>
References: <20230103162042.423694-1-james.clark@arm.com>
 <PH0PR18MB5017223066D8744D12C1F1BAD6FF9@PH0PR18MB5017.namprd18.prod.outlook.com>
 <5acce414-eabb-3d22-4907-da6b64b85a9c@arm.com>
 <b61039b1-1f64-ff1e-8e6a-7d8ada28656c@arm.com>
 <PH0PR18MB50178B52ED081276D2404493D6FD9@PH0PR18MB5017.namprd18.prod.outlook.com>
 <70a94ad3-fe5d-b013-7f6b-dd83d2332e0e@arm.com>
 <5fc1e764-bafc-34e5-5ff9-8b62af99ac10@arm.com>
 <PH0PR18MB501732D8907DC909B2ADECDFD6C59@PH0PR18MB5017.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR18MB501732D8907DC909B2ADECDFD6C59@PH0PR18MB5017.namprd18.prod.outlook.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 20, 2023 at 05:30:30PM +0000, Tanmay Jagdale escreveu:
> > On 13/01/2023 11:12, James Clark wrote:
> > > On 12/01/2023 15:33, Tanmay Jagdale wrote:
> > I've sent v4 and I don't see any issues now with the files that you
> > sent. There were a couple of different edge cases that I listed in the
> > last commit message. Let me know if you find any more, otherwise if you
> > leave your review or tested-by tag that would be great.
> I have tested the latest v5 version on our platform with test
> cases that run with and without filters for kernel/user space.
> The timestamps look good on all of them.
> 
> Thanks for the effort !

Can I take that as an:

Tested-by: Tanmay Jagdale <tanmay@marvell.com>

For all the patches in this v5 series?

- Arnaldo
