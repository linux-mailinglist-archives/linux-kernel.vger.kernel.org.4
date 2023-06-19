Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AE2735B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjFSPZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjFSPZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:25:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB4E10F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:25:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687188341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OlByzkjBxCCoZPdq7IqMTUU0TdOfFw/RoPP6ta6MsEg=;
        b=OJndYAmzwlCvlvcQALNMSD+ywOsIeWhWu3Cyixs1oMxmW2zwTTqk4NNcSIEJZxnv62phRO
        wVoYBQ5MYOIQUtCN82meFx1gzsZyZqekVkdRKGTE1dk6sPw6gLym3/ktqLTenzmT8qYGXx
        E8gqjTChs9J4+WUJp/KPj+RyQ1D9w1yxE5+Z8wtT/HLJ90i0Ln0VtBHHKnw1OHTihT8k/Z
        T01tmYnEqtCp6bSlSCxJm+717GYcrJE7yucCb2Qngjass/sh9tufu96pfNg/3s5X9Vg6c+
        VkPb39h76nu5+xPdvBzIYkBKsv64p/eLS6imqvaD+SustPq/MHL1kHza2VgQ7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687188341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OlByzkjBxCCoZPdq7IqMTUU0TdOfFw/RoPP6ta6MsEg=;
        b=P895Flm1FoG4VYzeJtEf+6sjjAQfWCLSGFQRLJ5iKZHtv2VlnZAkDPH9ri0UvI6xndQZKs
        KQN+0+bt+OptdRAA==
To:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        suresh.b.siddha@intel.com,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v1] x86/apic: Fix kernel panic when "intremap=off" and
 "x2apic_phys" are set
In-Reply-To: <ZI+EARkh3xsvkRfA@grain>
References: <20230616212236.1389-1-dheerajkumar.srivastava@amd.com>
 <ZI+EARkh3xsvkRfA@grain>
Date:   Mon, 19 Jun 2023 17:25:41 +0200
Message-ID: <874jn3qxsa.ffs@tglx>
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

On Mon, Jun 19 2023 at 01:24, Cyrill Gorcunov wrote:
>
> Hi! Good catch! In long term I think we could switch to use
> x2apic_state variable instead since at the moment the code is somehow
> hard to read and remember which exactly deps are to be satisfied to
> enable x2apic mode.

It's on my todo list for a very long time. Unfortunately that list is
growing only into one direction...
