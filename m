Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A20B5F7A0D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJGOzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJGOzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:55:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FEEA4B93;
        Fri,  7 Oct 2022 07:55:43 -0700 (PDT)
Date:   Fri, 7 Oct 2022 16:55:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665154541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bI7E79FQMAI17v4i6+zLzijvUIaxAAlZBL/lvElcWy0=;
        b=NmuaFzzv4B0qODfJcpSABgzEKvOCy7frMJuU0zXVjzo4YUCc9W2MlSN0mtV7VFD6xQ4Zt/
        axHbFqR/Jj3goSH9LDWksiuA4Uz0e5awPtokVRRuTo+sZVpbr0yfZE89goWmhE+9LLUHR7
        KYE9dRcppF2We0nWDzP6QFaPDzcWuWGQHMzAGWwVXEWU8XI6gmRP3Z98P5kR6JwlOD0T+P
        wkAGVjQoTSV/dF5OgJBQSCDJEwI8OgDqCbnH0Pb+GEU2p8bgKfsJp49mJb5iRE2fEE/OeP
        ecPRzqpNfw7p6/5mlxCqgarCutB4A9nCVXC4nnHlEUTieXydoaJmnDCcvoUhgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665154541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bI7E79FQMAI17v4i6+zLzijvUIaxAAlZBL/lvElcWy0=;
        b=DcvVkn3t25Bno8NohOBGEZR/zJRiER3fQbfUW69BFy0yVyRns3+Q9Oi/HdPcZEw14zRPdp
        4QQzOhxCQ/hQIrAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH 2/2] random: spread out jitter callback to different CPUs
Message-ID: <Y0A97NrHvzkfaG0J@linutronix.de>
References: <20220930231050.749824-1-Jason@zx2c4.com>
 <20220930231050.749824-2-Jason@zx2c4.com>
 <YzgGmh6EQtWzO4HV@zx2c4.com>
 <Yz2+UsgVGRSm+o7W@linutronix.de>
 <Yz3yQzaNUcdIuUMX@zx2c4.com>
 <Yz55w4gNtZn8JzmG@linutronix.de>
 <Yz7JXEaTFWa1VLKJ@zx2c4.com>
 <Y0AxMObsOLfqEjLt@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0AxMObsOLfqEjLt@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-07 08:01:20 [-0600], Jason A. Donenfeld wrote:
> Here's a reproducer of this flow, which prints out:
> 
>     [    4.157610] wireguard: Stack on cpu 1 is corrupt

I understood Sultan's description. The end of story (after discussing
this tglx) is that this will be documented since it can't be fixed for
add_timer_on().

Sebastian
