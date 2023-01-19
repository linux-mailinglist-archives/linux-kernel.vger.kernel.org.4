Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D76733B9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjASIcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjASIc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:32:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DA75AB53
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:32:25 -0800 (PST)
Date:   Thu, 19 Jan 2023 09:32:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674117143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TmrJSqLe0Kzc3iV/lLlnlsBxYG9x8L9YpROtD+7dxhI=;
        b=zj5/zJeX2oZ6X8PR5xB+7XcU6/D0VmJpiJmRnNOSN8FVEmLyCVwTne6SboXRlrjgxLYbxO
        LwS5X/F+UfhhSi7WAZh127uW3abzqub02uhAJQtMf5cPGNv9XeSAcF1VHAv4dZsUAZoRdQ
        bgipSi6zI6FsB1UvS87wWwg/EcQFM6fH59zelKjdWhLayRjDPBd80w0/TvFqkirngT8Bm0
        F7kgvxeaBc+wLaKabUTnDHLBekrlnBZE/h1KNYIx8PVJsy7aC580QLgdF5uBb8E0FLjDSE
        9NaKRBST+e2TLRiAUyetTTSjdRLkLUt2m+LuJ+I4LJwvLhZc2HFlC7E8P61msw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674117143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TmrJSqLe0Kzc3iV/lLlnlsBxYG9x8L9YpROtD+7dxhI=;
        b=9pNbI3J1w/ieCG65fZGpgxw5G8xrSpXRpEScS5Bw0tI8HvT1DUbnOIg20juWhrFAPMcklv
        gHDN7PFMzqfF2EAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <Y8kAFr+DfJJar0yD@linutronix.de>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
 <Y8gPhTGkfCbGwoUu@linutronix.de>
 <20230119011538.3247-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230119011538.3247-1-hdanton@sina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-19 09:15:38 [+0800], Hillf Danton wrote:
> But starvation remains same given RT contenders, even if prevent is put
> on your subject line.
>
> What sense could the 4ms deadline make at best if RT contenders extend
> it to a week?
> What will happen if RT contenders are hurt by the starvation deadline?

As far as Mel's efforts go, I am satisfied so far. Maybe you can improve
it further afterwards.

Sebastian
