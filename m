Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028B673486D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjFRU40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFRU4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:56:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E86123
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 13:56:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=80zSDouk0Pz5PYDC8ofRBo/DLaYMErhK8kdE7HknteM=;
        b=JQkMJx/cKObx5SbKv6uQkN2aI1FDIg2TXsWysWRog1kXoIv1Ip+MEEJRoEcjjneNHQvPxU
        dDQguWjTgfiU5I9AZZsz1eW5LizXRxflEDFrpQ7vrQWxWA0BvQMQXYZVkVEXz9s5TP4+fy
        pdhbrET6fkEzCR/bQxuicYBwi/0TsAy8M05spG78kyPLoybRiCaeZGNFhl8+yDb7Xv/Zh+
        X5lQkJ8Kotdlwrvs6VKoOkriy6UhuGcolK9TV3DCB4PPPlVT1nmJrRc3W89fia9wO3+O/C
        WGCEpXK+D+aG+B9rQdNW50pXWO7++MRT2JAe8gafUbUz+S24ljN9GMvDAjkUGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=80zSDouk0Pz5PYDC8ofRBo/DLaYMErhK8kdE7HknteM=;
        b=STOPmkG8Rs5PDxEN71jQH8KMhWbbD/KxPUMmDi55mq07Nr73dlVUvqbmSyatrnqqQVuPCO
        rxou/LqAHYZst3Dg==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH v3 2/5] x86/entry: Rename ignore_sysret
In-Reply-To: <20230616125730.1164989-3-nik.borisov@suse.com>
References: <20230616125730.1164989-1-nik.borisov@suse.com>
 <20230616125730.1164989-3-nik.borisov@suse.com>
Date:   Sun, 18 Jun 2023 22:51:22 +0200
Message-ID: <87sfaoqyt1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16 2023 at 15:57, Nikolay Borisov wrote:

> Give ignore_sysret() a more descriptive name as it's actually used to make
> 32bit syscalls return ENOSYS, rather than doing anything specific with

That's not really correct. This is not about 32bit syscalls in general.

It's specifically about the SYSCALL entry point on 32bit, right?

The reason why this is required is because 32bit SYSCALL cannot be
disabled in hardware.

Thanks,

        tglx


