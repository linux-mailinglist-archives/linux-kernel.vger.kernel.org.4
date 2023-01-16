Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF4066BAF1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjAPJxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjAPJwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:52:30 -0500
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE0118B2D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1673862700; bh=GGWZqurGVXYXKjiSWb48WruguAOsrq5zDLR1T8LYJYQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Dv/YkebidJycejB8ZSKlLlgZmGWe7U0ihJbL01oIY8LfRzd2tv0dOC0HeB7LW69mk
         aJ57mUEGBsrA+1f5RBFOfzYDk84PtIkPCGrGfn3nRMTCgCoSjxXI98n4qBLgJZLF+W
         yS2Q/n8mRXsnjdQyg/SArqy7/zwlmiTaFlmdZ1LiWWmgMhCvaFxbCXOJZ9Qbig4MIW
         RDxlRONX7K02+GASBsxBV/PFdl6/gTNONUe9XXVoIDpGfnnTt3nE7uxQBXCr9Dfrdn
         98g9uk5URmbgOK2EKBS+rDFlRbS9k2eiIaYXLKdCefFaPdva4rK3BOJK43zD/AytSz
         C4r95u1zb2qbg==
Received: by gentwo.de (Postfix, from userid 1001)
        id 447CFB00195; Mon, 16 Jan 2023 10:51:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 43326B0011F;
        Mon, 16 Jan 2023 10:51:40 +0100 (CET)
Date:   Mon, 16 Jan 2023 10:51:40 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     Frederic Weisbecker <frederic@kernel.org>, atomlin@atomlin.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 2/6] mm/vmstat: Use vmstat_dirty to track CPU-specific
 vmstat discrepancies
In-Reply-To: <Y77s4x5yC4O1OxTQ@tpad>
Message-ID: <24ca2aad-54b2-2c3a-70b5-49a33c9a33@gentwo.de>
References: <20230105125218.031928326@redhat.com> <20230105125248.813825852@redhat.com> <b89a9828-d4e-9874-d482-dbb6cbe46@gentwo.de> <Y71XpnJGumySL9ej@lothringen> <7c2af941-42a9-a59b-6a20-b331a4934a3@gentwo.de> <Y73F4tbfxT6Kb9kZ@tpad>
 <60183179-3a28-6bf9-a6ab-8a8976f283d@gentwo.de> <Y77s4x5yC4O1OxTQ@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2023, Marcelo Tosatti wrote:

> OK, can replace this_cpu operations with this_cpu_ptr + standard C operators
> (and in fact can do that for interrupt disabled functions as well, that
> is CONFIG_HAVE_CMPXCHG_LOCAL not defined).
>
> Is that it?

No that was hyperthetical.

I do not know how to get out of this dilemma. We surely want to keep fast
vmstat operations working.

The fundamental issue that causes the vmstat discrepancies is likely that
the fast this_cpu ops can increment the counter on any random cpu and that
this is the reason you get vmstat discrepancies.

Give up the assumption that an increment of a this_cpu counter on a
specific cpu means that something occurred on that specific cpu. Maybe
that will get you on a path to resolve the issues you are seeing.



