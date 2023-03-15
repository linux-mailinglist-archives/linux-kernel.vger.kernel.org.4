Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3AF6BC221
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjCPAHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjCPAHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:07:37 -0400
X-Greylist: delayed 583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Mar 2023 17:07:07 PDT
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D1361ABF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1678924580; bh=HELdY/NMjq+c5Rkpy0uqmSSxU4Vqd4oCpA5llE3DmGc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=LgRDJVwg3d/6rGzJ9a0bB+aym1i26mqReOySLxyl8GMB/mx/jZzur1vxnf4yUISHk
         35co2Hmg7NXz1e3QY82k3e8alRSxoLDemqlRX+qQ69+W+03uuIG101n3psWzBHavcG
         6uSl1me/2z/fT4nXsRN4KePOf4q/Me71a74PWHHIxvMJco0L6ULm4WuKtapibXRaHt
         GsSTbw5/VApSHCByZn+UVsfaeO+akoYBegMGh7KD8IIQlsSwLxdQKo+zL7NBhTlIgM
         /W2FP6FnEWbY0o5jqN7UIaFfSO8/E/TLQLc4DfpyXlX5rt+bWITWhRVGlufyC9ez7/
         C5Is9QYP3hqoQ==
Received: by gentwo.de (Postfix, from userid 1001)
        id 488FDB00162; Thu, 16 Mar 2023 00:56:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 46DF1B000AB;
        Thu, 16 Mar 2023 00:56:20 +0100 (CET)
Date:   Thu, 16 Mar 2023 00:56:20 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 02/11] this_cpu_cmpxchg: ARM64: switch this_cpu_cmpxchg
 to locked, add _local function
In-Reply-To: <20230209153204.683821550@redhat.com>
Message-ID: <df9e3ddc-e3be-4ceb-af7f-e5557b9228df@gentwo.de>
References: <20230209150150.380060673@redhat.com> <20230209153204.683821550@redhat.com>
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

On Thu, 9 Feb 2023, Marcelo Tosatti wrote:

> Goal is to have vmstat_shepherd to transfer from
> per-CPU counters to global counters remotely. For this,
> an atomic this_cpu_cmpxchg is necessary.

The definition for this_cpu_functionality is that it is *not* incurring
atomic overhead and it was introduced to *avoid* the overhead of atomic
operations.

This sabotages this_cpu functionality,

