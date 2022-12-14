Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F9864C63D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbiLNJsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiLNJse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:48:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7711164
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671011272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XpyPWrof9YGyhLIHZW+hprXwCnTR/L0ZFYZQ7acgHqY=;
        b=KN8xHkcMNfbzcc1A5qy9UvZBQyCsP2luxrV0ja1ucBAgyulJSF1HtjhYAw9Hj9FWm5P/x3
        we+hZ2MQMTznON98tQqXqfdIGciXvvkX6Muhkmw2c8fgB0S5GViyy+3OrKBB0EXg0GKeV4
        eceXgtGCBPTRh3hty7q7ZXcQyhka4A0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-I7V76jiRMw-fljtAW46_2A-1; Wed, 14 Dec 2022 04:47:51 -0500
X-MC-Unique: I7V76jiRMw-fljtAW46_2A-1
Received: by mail-wm1-f72.google.com with SMTP id o34-20020a05600c512200b003d07ee4a667so1385384wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpyPWrof9YGyhLIHZW+hprXwCnTR/L0ZFYZQ7acgHqY=;
        b=r7G4nytQmWy2esGuMr0xNQKJS7JdAf+CjhYaK+JBO7s1eq64ptl78SQj8O7i+bjAH/
         urXRDHSWP6SGBJ2AfxtXIyMM7CiGPH8fKgE59vQc8pCiMD9T9w8JcO+U/GovEGdnTd4Q
         E0KmX52cB879schg2suf1w2mXLs9qSbiOoZlLHW6nRWB50rU5eG3BB2OoEzHeaWyl5dV
         0JxS53ARQz22+ys8jdvwxy0Woqys3PXeR8NifF3UPkcDsiCNvcEit0qJhCmTWaKrBs0z
         Wo8MaK5Q9+jYGC2NLxKzeA9VvPqTFMvZ7CAbnsucUgN4FwyyLh7vAMXKrTMEsHwwp00s
         ks2g==
X-Gm-Message-State: ANoB5pkqdvsT/xEHYTNx1R1xoCsdujgstOrmLoLz3lobdRuBIVVvWOeK
        ODo0Dm5JueamoKINB27h6DAvk3ULAPIjgAvlIIOwEx0pIXx51iUKp/yMfudtHKBOC4Qm38Bh5Nb
        01gbsjtUsPWSE6tqYu2e8nblq
X-Received: by 2002:a5d:5f07:0:b0:250:22e4:b89e with SMTP id cl7-20020a5d5f07000000b0025022e4b89emr7232194wrb.65.1671011270593;
        Wed, 14 Dec 2022 01:47:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5FSldeehkRbpkeky01V8o2IWPnGBQEL4yjGgH9Qh6faFVIGJUrOc8mHaClJ/z2esWUu/jBQg==
X-Received: by 2002:a5d:5f07:0:b0:250:22e4:b89e with SMTP id cl7-20020a5d5f07000000b0025022e4b89emr7232183wrb.65.1671011270431;
        Wed, 14 Dec 2022 01:47:50 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id c24-20020adfa318000000b0022cc3e67fc5sm2398247wrb.65.2022.12.14.01.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 01:47:49 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>, Tariq Toukan <tariqt@nvidia.com>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] lib/cpumask: update comment for cpumask_local_spread()
In-Reply-To: <20221213043248.2025029-1-yury.norov@gmail.com>
References: <20221213043248.2025029-1-yury.norov@gmail.com>
Date:   Wed, 14 Dec 2022 09:47:47 +0000
Message-ID: <xhsmh359i71vg.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/22 20:32, Yury Norov wrote:
> Now that we have an iterator-based alternative for a very common case
> of using cpumask_local_spread for all cpus in a row, it's worth to
> mention it in comment to cpumask_local_spread().
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>
> Hi Tariq, Valentin,
>
> I rebased your iterators patches on top of cpumask_local_spread() rework.
> (Rebase is not plain simple.) The result is on bitmap-for-next branch,
> and in -next too.
>

I had a look, LGTM.

> This patch adds a note on alternative approach in cpumask_local_spread()
> comment, as we discussed before.
>
> I'm going to send pull request with cpumask_local_spread() rework by the
> end of this week. If you want, I can include your patches in the request.
> Otherwise please consider appending this patch to your series.
>

It would probably make sense to send it all together, especially since you
went through the trouble of rebasing the patches :)

Thanks!

