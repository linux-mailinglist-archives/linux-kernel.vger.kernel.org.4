Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997B867D82A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjAZWHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjAZWHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:07:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A112B28D16
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674770777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJ/8nX4zvnH/ty2ST5KcgskeZg0+7IEmI7sIejuxW3M=;
        b=eRjUnXERP44INWX7DOQxDNtFDt6RYNSxTxeoezERfFqvUg7P6sKoHG6CwEILXcSp3eAGrX
        YDrFSWt5KBcqIdiOU1VvCadKfSKrA7ulU2fge6JILHhX5Gj1O+Dv15P4DoM4kLhQmCtm+3
        pv8ehqrumm3OJmo7Yu1fe/fTzwyuRLE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-345-i70j_RS3M0yDBZivYhJXgw-1; Thu, 26 Jan 2023 17:06:16 -0500
X-MC-Unique: i70j_RS3M0yDBZivYhJXgw-1
Received: by mail-qt1-f199.google.com with SMTP id j14-20020ac874ce000000b003b6917d0731so1407954qtr.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:06:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJ/8nX4zvnH/ty2ST5KcgskeZg0+7IEmI7sIejuxW3M=;
        b=rfSjwJfA2ypHfsR5D6vbVtDklK1kMnRV8W3LN2OqW2YpQdbV60cqD1Hc0USOur1T03
         Tv6xiC6ZNqwPFjeuFqPuzPCPQU9ZM+gZG0CyI6EFe6NMUBmDKIu0JNr08dD3qX7X8gMN
         /BhHnthV3kJL15yKKDtyMmI/cb4+sT099xrGHCqKVhOCswEP/1n47NdZVE5hMm7mSdxf
         veiukRPn+wRvBgFsd2182kUM+eVMqFdVZNcmZZO0FUcLAf/6ZiN72HfGUHbwXcUUvV8f
         0rgC1d/SzGZ4K76CB3ojlbem/csx1w6CgLYNYzeHI5E1kUqcy6936r7vHR2K58xIgDyK
         D+3Q==
X-Gm-Message-State: AO0yUKV10VFAm3gx2vnARXE+QbwgC5XZQaC8yc0lM96ovMCSzY/ghGe2
        VAvwdrwMoAfXjYFQKsvbvA5+JhTwQg7lo3QNZFNUQGNKfKWoRqAlitoyLW6UmhdILu0JvVgi3E8
        itxi5p7O5GyZxOmkHPNnQyt/M
X-Received: by 2002:ac8:5c09:0:b0:3b6:377d:4330 with SMTP id i9-20020ac85c09000000b003b6377d4330mr14060710qti.29.1674770775836;
        Thu, 26 Jan 2023 14:06:15 -0800 (PST)
X-Google-Smtp-Source: AK7set9yWYt2rhCoYu5m2yMmMGUlTPpm6onbgSgfZq2E5c1G86CongsU6U+8xg6KgYsC0Zolr+xW1g==
X-Received: by 2002:ac8:5c09:0:b0:3b6:377d:4330 with SMTP id i9-20020ac85c09000000b003b6377d4330mr14060673qti.29.1674770775515;
        Thu, 26 Jan 2023 14:06:15 -0800 (PST)
Received: from fedora (modemcable181.5-202-24.mc.videotron.ca. [24.202.5.181])
        by smtp.gmail.com with ESMTPSA id br9-20020a05622a1e0900b003b62e8b77e7sm1493538qtb.68.2023.01.26.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:06:14 -0800 (PST)
Date:   Thu, 26 Jan 2023 17:06:12 -0500
From:   Adrien Thierry <athierry@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4] cpuidle: psci: Do not suspend topology CPUs on
 PREEMPT_RT
Message-ID: <Y9L5VFPdDnsiCluu@fedora>
References: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

I tested your patch on the Qdrive3/sa8540p-ride on 6.2.0-rc3-rt1, and it
fixes the issue I encountered in [1].

Tested-by: Adrien Thierry <athierry@redhat.com>

Thank you,

Adrien

[1] https://lore.kernel.org/all/20220615203605.1068453-1-athierry@redhat.com/

