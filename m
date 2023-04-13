Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4A26E08A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjDMIKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDMIKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:10:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02362717
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OoO5x34suwsOpopdEX+ItDuoVzC/7czjI+wGKkOTJ+k=; b=nDYLdrmAMFcOcUo19i6oa3yqjH
        qaC191fNekOl313mXFAY0MN/1RvvySiCM7Y766WLfLW5KjqbcSNkkzqpkVbVYvyh2NTPFNr7GsbSe
        VPnUeikWMbE0EVR0KvjqImURohfk9VX+ilbK78RTLgMXBUmLxOaXuKJbGWOH3kt7angxKI9Vcq49P
        QIXTCCuGmt7Iz9YdiDGFaE5NXPlydbgBZ23UgMRTX3d3KrK1zI3CJFiFiCHVB0A9YRiDD0pThLWMw
        Bk05Newu5c8PFNvMYyfZ7TVehOThxhbdE9YClKGpibwd22o8QmHk807d6fs/AGPf8i4tKaU9Y0Dtr
        B8Nwb2XQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pms0F-00EfeD-0d;
        Thu, 13 Apr 2023 08:10:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BCCBA30002F;
        Thu, 13 Apr 2023 10:08:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A06A8235CC4A0; Thu, 13 Apr 2023 10:08:22 +0200 (CEST)
Date:   Thu, 13 Apr 2023 10:08:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 5/9] objtool: Add verbose option for disassembling
 affected functions
Message-ID: <20230413080822.GH4253@hirez.programming.kicks-ass.net>
References: <cover.1681325924.git.jpoimboe@kernel.org>
 <4cadacc719db1e792c335309056960ca6f71139e.1681325924.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cadacc719db1e792c335309056960ca6f71139e.1681325924.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 12:03:20PM -0700, Josh Poimboeuf wrote:
> +	objdump_str = "%sobjdump -wdr %s | gawk -M -v _funcs='%s' '"
> +			"BEGIN { split(_funcs, funcs); }"
> +			"/^$/ { func_match = 0; }"
> +			"/<.*>:/ { "
> +				"f = gensub(/.*<(.*)>:/, \"\\\\1\", 1);"
> +				"for (i in funcs) {"
> +					"if (funcs[i] == f) {"
> +						"func_match = 1;"
> +						"base = strtonum(\"0x\" $1);"
> +						"break;"
> +					"}"
> +				"}"
> +			"}"
> +			"{"
> +				"if (func_match) {"
> +					"addr = strtonum(\"0x\" $1);"
> +					"printf(\"%%04x \", addr - base);"
> +					"print;"
> +				"}"
> +			"}' 1>&2";

Do we want to have scripts/objdump-func.awk and use that to avoid the
duplication and eventual divergence of these awk thingies?
