Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D6772F7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbjFNIdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjFNIdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:33:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BFB19AC;
        Wed, 14 Jun 2023 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kfogN8xbf7/stcsXdqrLFvOjiQCC1x162a5W5DN6bEk=; b=e+2/4S4ZBZlNXOGN1LVdbSvAUZ
        AXLgS7Ai/PPFdhlX18C4SNeStJXNyrIWQXyV5Rqbu4rhpuViH2ZUToPkyb2oWIfwqp0RH3T9zm4zb
        MRLmBfLuo0iV0B/17KNaQNK/NWyt7MhbDY3A4IuYeUtIWO2V8boESpK61l6iCvUwkr19WSj2vlRFO
        S7cZ9aK8Z3NWFNzIiLY1qsf+skB+uLvUxAuE178/TwZbFckYtbxy4bbANsgus0ZK9iWjCZAN5RJ2I
        ATbvWPJ9+rRCNbbHuHyiw7WsReWdbYF8AwXnVBBP9sAVoiYBIIv0030RScqPD45Eamwi2Gn9gcY9u
        v8W1PaSQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9Lvl-00AcBr-0D;
        Wed, 14 Jun 2023 08:32:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F3A73002F1;
        Wed, 14 Jun 2023 10:32:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56C6F27F86A4E; Wed, 14 Jun 2023 10:32:40 +0200 (CEST)
Date:   Wed, 14 Jun 2023 10:32:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     alison.schofield@intel.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] CXL: Apply SRAT defined PXM to entire CFMWS window
Message-ID: <20230614083240.GC1639749@hirez.programming.kicks-ass.net>
References: <cover.1686712819.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686712819.git.alison.schofield@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 09:35:23PM -0700, alison.schofield@intel.com wrote:
> The CXL subsystem requires the creation of NUMA nodes for CFMWS

The thing is CXL some persistent memory thing, right? But what is this
CFMWS thing? I don't think I've ever seen that particular combination of
letters together.
