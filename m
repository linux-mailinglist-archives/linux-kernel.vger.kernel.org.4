Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056256DCA1F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjDJRmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDJRmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:42:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0515F2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:42:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n14so30386150plc.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681148539; x=1683740539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=McB7Sh9UbvzmVUNszMLvZEEZhXfz8keqD9x6se8/cVk=;
        b=hRRw/xGN5b/KIwK6Wp3KPPp9nc+ATxJ/xIcT2bU3/88zlA8XNZn4fHN6au39n9+S87
         LFxMA3Of152bXP/D4HmcN/qhLLu8TdZ2W6WnfQJMRWubAiaAOsTsiUNttfEmv3ujZuXO
         UFBSWq3nuul/5rwU+0jho8QEHQc/d3+yiCcG4tcq8eU0XJNcT7qchKy2u33kjvP7amxQ
         EbrRtfBIMbLm/n8d4K6mtSzEkS1aveAsCokFxlQ5IVq/8+QJey78U5pW/RfTnWlpv3M8
         OBDHj1EiykkzTuSWErmR6WUFdVEV0sn/zpvy+oRim5peb7xvGhMQqw5l2k2S9z3r7nLd
         cBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681148539; x=1683740539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McB7Sh9UbvzmVUNszMLvZEEZhXfz8keqD9x6se8/cVk=;
        b=4CZIfZ/r9mnGQXFaWxcIGOhtLhZRffSjOKgysLokWmWhny1Zwg9qfn0VpSataVHn2x
         kDRbDLjupMh3cXUREztmjHfybH7WkROwcqgQ0mhVfFVfFhvaPQOkLRPs1RFkMrc1ar11
         IT7TEqSdTkxls8GcGCDS1oKkKpS32n2SLSB0b5V6f13teW8p0yLFj7vXqU3fwN1zBU9j
         54/uukbgM+DfHCf9TjRXFa9wO2vlwkokBtVg0HI8cUpwwOHEM3JgwFb259PiuE6w3TLn
         DgQ+WEJydPTojKps5MvnitatB8QaGtlnBX4PtTRCybca7i83bt8tZJu9gMdIjQNXm/m4
         KbKA==
X-Gm-Message-State: AAQBX9fpuak6tJyR/1SrG4nK5eyuNdrN3ABlsNkQhwYumP4pFxK/2Y2y
        B+j8vo+lQ+mLw4zOOnft1lY=
X-Google-Smtp-Source: AKy350YN37ogoqIAIttjNkNTh4VLPUy4tLa8PeQqU/4D0PZ/k0QPXXeNR2GFfpJVo57NsME/kAToyA==
X-Received: by 2002:a05:6a20:6504:b0:d9:162d:98e8 with SMTP id n4-20020a056a20650400b000d9162d98e8mr11148466pzg.13.1681148539257;
        Mon, 10 Apr 2023 10:42:19 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id i26-20020aa787da000000b0059442ec49a2sm3008019pfo.146.2023.04.10.10.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 10:42:18 -0700 (PDT)
Date:   Mon, 10 Apr 2023 10:42:17 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, dchinner@redhat.com,
        yebin10@huawei.com
Subject: Re: [PATCH v2 1/2] cpu/hotplug: introduce 'num_dying_cpus' to get
 dying CPUs count
Message-ID: <ZDRKeXg8F4qGj6gW@yury-laptop>
References: <20230406015629.1804722-1-yebin@huaweicloud.com>
 <20230406015629.1804722-2-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406015629.1804722-2-yebin@huaweicloud.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 09:56:28AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Introduce '__num_dying_cpus' variable to cache the number of dying CPUs
> in the core and just return the cached variable.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

It looks like you didn't address any comments for v1. Can you please
do that? Otherwise, NAK.

Thanks,
Yury
