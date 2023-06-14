Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833F272F59F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243293AbjFNHNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243075AbjFNHNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7B098
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686726734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/U0BSwcxwtPDblW2SZCJPehi+/SQaSwVgJ0GDSC97g=;
        b=e3GYzJt1zYxuVIW24Hxo6+/xODtfqizwnS5zEaexCtkWseWTEs3Xwcndzf73dlYUvKqvPc
        20nN6NR4L88fvXrDFq3051lMGTKSlCU0kOhnvSrNAxCn9KOUuV5g3XvqlwgpWq/ZPNcKFV
        JxjxBSmiK935Q3AXUKvKA0YkAKdzTzk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-8AA848-1NMWTIuFh4u6IzQ-1; Wed, 14 Jun 2023 03:12:13 -0400
X-MC-Unique: 8AA848-1NMWTIuFh4u6IzQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-25e0bab24aaso174047a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686726732; x=1689318732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/U0BSwcxwtPDblW2SZCJPehi+/SQaSwVgJ0GDSC97g=;
        b=l8VmO6EMSy+hxK3nHjK7bYbO11nwjMsQasI/7q/hwmxSjys8HyyUw0srlvRW59h7SN
         4MOjysXUlwNsi34ThBLLWQL1vURqk6deZY6ki4mBYKwdoeVgCOWCsRJ4QeYZ/gemlgHJ
         C5t4hIQNGEPyyg9LGTWVLk0FyT9AQufDiU2PHNsmjI6n1JVsEmf4B3Yv4OdkmHo7hINR
         mNO4tDp7+xnE+X1LWX6Mhzoa1rFF/qdsvEMjgwP9WgQLreA5M4pJFsJ6M51nxq4c2AeH
         mzdLwIZfwwzUXDIDBsyCRZasYhHoXMay/TiT8OVHvfxhNuOj5nKOwEhLNWHm1fsKb81N
         LeQg==
X-Gm-Message-State: AC+VfDweibLFRFopsX3KftPuq/yO6iOD1RfIIbiqClZCgLCJlnOGEiE9
        BXHyNN8CHSGDt0h2rXyZUNJ8xw7IOgOPqFz3ehUXlCboNBiEMo3FU4xVCBoKZJ4ZXHF+eCzdVwC
        3NsksY15Nwp3bqQV88Zb8h76SVT35euJYxik/9Hh+
X-Received: by 2002:a17:90a:1cf:b0:25b:ec4c:488b with SMTP id 15-20020a17090a01cf00b0025bec4c488bmr836265pjd.34.1686726732572;
        Wed, 14 Jun 2023 00:12:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xfVTtramTVR8uEZ8x1k3b87HRutoNm0rx85rGzKvGkxcTI2Uo0acNpC2eoMSozO2LyB1S30w8RoTHzLfhCJo=
X-Received: by 2002:a17:90a:1cf:b0:25b:ec4c:488b with SMTP id
 15-20020a17090a01cf00b0025bec4c488bmr836251pjd.34.1686726732274; Wed, 14 Jun
 2023 00:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-5-yukuai1@huaweicloud.com> <05aa3b09-7bb9-a65a-6231-4707b4b078a0@redhat.com>
 <74b404c4-4fdb-6eb3-93f1-0e640793bba6@huaweicloud.com> <6e738d9b-6e92-20b7-f9d9-e1cf71d26d73@huaweicloud.com>
In-Reply-To: <6e738d9b-6e92-20b7-f9d9-e1cf71d26d73@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 14 Jun 2023 15:12:01 +0800
Message-ID: <CALTww292gwOe-WEjuBwJn0AXvJC4AbfMZXC43EvVt3GCeBoHfw@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH -next v2 4/6] md: refactor idle/frozen_sync_thread()
 to fix deadlock
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     guoqing.jiang@linux.dev, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org, linux-raid@vger.kernel.org,
        yangerkun@huawei.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:04=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> Hi,
>
> =E5=9C=A8 2023/06/14 9:48, Yu Kuai =E5=86=99=E9=81=93:
>
>
> >>
> >> In the patch, sync_seq is added in md_reap_sync_thread. In
> >> idle_sync_thread, if sync_seq isn't equal
> >>
> >> mddev->sync_seq, it should mean there is someone that stops the sync
> >> thread already, right? Why do
> >>
> >> you say 'new started sync thread' here?
>
> If someone stops the sync thread, and new sync thread is not started,
> then this sync_seq won't make a difference, above wait_event() will not
> wait because !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) will pass.
> So 'sync_seq' is only used when the old sync thread stops and new sync
> thread starts, add 'sync_seq' will bypass this case.

Hi

If a new sync thread starts, why can sync_seq be different? sync_seq
is only added in md_reap_sync_thread. And when a new sync request
starts, it can't stop the sync request again?

Af first, the sync_seq is 0

admin1
echo idle > sync_action
idle_sync_thread(sync_seq is 1)
echo resync > sync_action (new sync)

Then admin2 echos idle > sync_action, sync_seq is still 1

Regards
Xiao

>
> Thanks,
> Kuai
>

