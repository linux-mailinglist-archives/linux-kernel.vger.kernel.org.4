Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E916A73BE7B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjFWSfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjFWSfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:35:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00EB297E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:34:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f9b9863bfdso14295e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687545238; x=1690137238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFzGjPYdkPeLa580A5dmqXwbEWChWY17BOjGL2B8RbQ=;
        b=qW6H4KE5B00XuTN5plNqdMOvo2AcsM7NayQk94xU1WS8vp1h1GDa3dQsbIP7eRRlVH
         6uS4TBIUqy/NN/sSc26InvNG3FU1VPGph1ngIw5hgBsqWA02WEXZXFHSqrnOPoczL4O+
         hMGuT2psBlfIvbuf2cnN7WGAcAOuWu3/B9ByL1OWhl9+1TRk0Mkpq+SdJIzdibYlXbvy
         0ujvQiuOWlon9FutKn6ncmUaaIPJ7itQGHLI5W23ZSAy34wnKfIzqw7FipCutnHCoilR
         K2EoIY1uhzy8zVNHJ1L1vNgU1f8syQuot1r6rGAs6svBZoiKQYmE46moABzwvW+OZs++
         B2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687545238; x=1690137238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFzGjPYdkPeLa580A5dmqXwbEWChWY17BOjGL2B8RbQ=;
        b=QgUyqMJeE3FyujYZlbUAskams3LWq4DUdmWQa27j5mJ1i56vulVb0/e+W62G9Du9M2
         vFW0QSexj7T4hz/LH7d9Jb1dn954fK2wMTIPS1MyChf78m4xrKAVWFiESqASAB2WtBXT
         sGXMwe79V9uHXbtWL9wxgWZF/hr/7tdz77FrJ+MRDIRVNdrLWamCNqB1zP4SBRz9fyQL
         O0XbjrGK+HIs7llREFUzB+D+pHxHC7/jTRZWPDglO5j06fLZZVro7G5VAoymrlfX/YsB
         LeD3MrhQzU+Z70Bf/+TDpCc/Wt8hG4gNzX7P4eraqLZ9y0/PU+fmOYz5dAV1rtn1nw5+
         0d1g==
X-Gm-Message-State: AC+VfDxbrZGVuAxzlqcQnA2UYZzwEHtYUXV1zhYn5EDS6560xvtS3Rrv
        ukOQgby/TO6K7pwXQWuZOHLojF9Fvr30IJZQH0dzv1KHRZfdxg9ll334eA==
X-Google-Smtp-Source: ACHHUZ7SyfhzGYKjueUbwB9hivD6Fub9obDC2CF5SuQNrl1nrzFpcm6h5ad2Q+GR4NjCSuFyWFC8VN0NLoy5ZAorXtQ=
X-Received: by 2002:a05:600c:3b84:b0:3f7:3e85:36a with SMTP id
 n4-20020a05600c3b8400b003f73e85036amr121483wms.7.1687545237987; Fri, 23 Jun
 2023 11:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
 <ZJIuG9hyTYIIDbF5@google.com> <20230622135204-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230622135204-mutt-send-email-mst@kernel.org>
From:   Edward Liaw <edliaw@google.com>
Date:   Fri, 23 Jun 2023 11:33:31 -0700
Message-ID: <CAG4es9VgFAcw5cuj8ErD8KqJ8P_eEgA+yXBCUeu_xp9Qp6M0hg@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "virtio-blk: support completion batching for
 the IRQ path"
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        "Roberts, Martin" <martin.roberts@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:14=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> Oh interesting, can you share how to reproduce the failures?
> Then maybe Suwan Kim can take a look at fixing up the patch.

I did not have a deterministic way to reproduce the failure.  I ran
these test suites 5x consecutively and that seemed to fail often
enough to let me bisect it.

I checked out the kernel at d645c62fd19af9c9246150a958450ffd26ad0bfa
Merge 84cc6674b76b ("Merge tag 'for_linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost") into
android-mainline, built it, and ran cuttlefish with the following
configuration:
tools/bazel run
//common-modules/virtual-device:virtual_device_x86_64_dist  # builds
the kernel with bazel
acloud create --local-instance --local-kernel-image
$ANDROID_MAINLINE/out/virtual_device_x86_64/dist --branch aosp-master
--build-target aosp_cf_x86_64_phone-userdebug  # run cuttlefish with
custom kernel

And ran the following tests:
atest --rerun-until-failure 5 vab_legacy_tests vts_core_liblp_test
vts_libdm_test vts_libsnapshot_test vts_ltp_test_x86_64

I'm not sure if that will be helpful for you, though.

On Thu, Jun 22, 2023 at 10:53=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> Does Android have VIRTIO_BLK_F_ZONED ? Could you list the
> features this device has please? Thanks!

It does not.

$ cat /sys/block/vda/device/driver/virtio*/features
001000100100111000000000000001001000000000000000000000000000000
VIRTIO_BLK_F_SEG_MAX
VIRTIO_BLK_F_BLK_SIZE
VIRTIO_BLK_F_FLUSH
VIRTIO_BLK_F_MQ
VIRTIO_BLK_F_DISCARD
VIRTIO_BLK_F_WRITE_ZEROES
