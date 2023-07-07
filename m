Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411D374B191
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjGGNPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjGGNPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9981FEB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688735659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6vnw9WeYBMqYt9YWOLp+S5fHsLpKwmQh+j83UzoShuI=;
        b=XB+2hyqX+RgG0KF7POd4w1+nySTTVymLEO7kr/t+09EBuSHf879ReoDc2tfWn05IUFNWel
        SBUFvLLHIArfJ2Wchv27PrkaTi2BJRF1KkCci8B+UMHzGbqAmCtwctmD53Ki4wydDebGD1
        /JrCpFenTvMECtJdVT0BVad/gj+DB8Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-EHDRChWCNVeHPgKts3tO3w-1; Fri, 07 Jul 2023 09:14:18 -0400
X-MC-Unique: EHDRChWCNVeHPgKts3tO3w-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7673887b2cfso47810585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 06:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688735657; x=1691327657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vnw9WeYBMqYt9YWOLp+S5fHsLpKwmQh+j83UzoShuI=;
        b=h8PChxIZsBkMC+zJR5wYRYu2tuJCWp7ge2eE/YGbG13wqwn8m9vUbmq6J957UeUJ8l
         IAZVn6KawrLjm5akvJWPVv8DJbfmkZYGEnE9pCyo6rMG1nOEywNmLevL9g2rxPty1gIX
         h05KNgQwlCUZmugHbB7EMuWu8sJ3R0xu9Qr9TDgWOMCXv1/UaWeWmIg3ZkJsKRNTVyhU
         GzPemvZJ3dv7Ix0k5g1VPxINN9kkl/lgcNmGKdjFua41Bzi+4kySI8EcmREUJ4gHXKJZ
         LcqJdCg1yWmrR/mZ6UBIuXXX/j58R9KxbCWSF4l2foYsboJFNY/nj9GAS260LdgxqcbF
         tW1Q==
X-Gm-Message-State: ABy/qLbVuaHvgWA9Fq4wVUh5xLd7vhy0eigoNR92U78MPt9SOn+EIOlk
        N2+lBGo+68EOqxgbajswo9sLPbCsLaN3DOXKkTU7ji1vLEeig/+HYFBzOrk243p3Pcl9HCggtnU
        O7/W1esnr3BG8QAwY+w0rqeJo
X-Received: by 2002:a05:620a:444c:b0:767:1573:d36e with SMTP id w12-20020a05620a444c00b007671573d36emr5602278qkp.3.1688735657686;
        Fri, 07 Jul 2023 06:14:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFM9ujXAoIaW0G5RqfQhUiyk9Pp98RfcrEYp1lty1Ca8TCUHVClMKEuALmkLm8iW1IpWPaeUA==
X-Received: by 2002:a05:620a:444c:b0:767:1573:d36e with SMTP id w12-20020a05620a444c00b007671573d36emr5602241qkp.3.1688735657399;
        Fri, 07 Jul 2023 06:14:17 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id a22-20020a05620a16d600b007671678e31fsm1800467qkn.86.2023.07.07.06.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:14:17 -0700 (PDT)
Date:   Fri, 7 Jul 2023 09:14:14 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/8] mm: userfaultfd: check for start + len overflow
 in validate_range
Message-ID: <ZKgPpkx0l7mZ6s5E@x1n>
References: <20230706225037.1164380-1-axelrasmussen@google.com>
 <20230706225037.1164380-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230706225037.1164380-3-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 03:50:30PM -0700, Axel Rasmussen wrote:
> Most userfaultfd ioctls take a `start + len` range as an argument.
> We have the validate_range helper to check that such ranges are valid.
> However, some (but not all!) ioctls *also* check that `start + len`
> doesn't wrap around (overflow).
> 
> Just check for this in validate_range. This saves some repetitive code,
> and adds the check to some ioctls which weren't bothering to check for
> it before.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

