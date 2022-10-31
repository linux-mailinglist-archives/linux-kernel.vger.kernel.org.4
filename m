Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719686138DF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiJaOVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiJaOVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:21:33 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA682DFD5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:21:32 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id x16so6262964ilm.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lhc4EkblHbbPD+96+0PH89wXhgm+3piSxAQSO0JjnxM=;
        b=tjGLldjIWv4CZmbKOjBjCVL2P6AtW9jdRflT4ONyaR2BLdWwfrOP8rW+Y42DhyBOu+
         NdSErUwhGEUrHYcP/1B0UKOFpMpVV6M8vH4j8U5WvONlQFetEG8KZ61AawGLHyOl98h+
         4Mf9MRc+CjFaJNoebRZhOuFAxdEK7uTaO8XiSmNiTYkLLVq2OvpuesUogdvUVtA5dsqN
         DNISFnyaBth3hyNkWjBfWYdYrAlS6EsRRi5hAJATU05UJxw4nhKytKESe+E3FSiQYy3r
         8Yh0Bvpj3FS0+F2xZAXe2Xqiwbkcb0QM+7d2hPKZCecFy/xlHdGga24Q2bsYO02XtMya
         HBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lhc4EkblHbbPD+96+0PH89wXhgm+3piSxAQSO0JjnxM=;
        b=ayWA3UGTy80CD5as8SSVnrWsiTjlkGCBdQiujuKr5ArzjD4BtGBNzkdCJ9nKxr/71F
         axIK3GIh31YmvX9Fsihz+fKJmm8MUmMfg40A1ibVgYfVtVnlqbDvXROCpqHPaxiDCG6B
         lx3Ad0F44lXsuFsQRyzZ/BNeJMBDU6ownPoQ61a7YTEGF4dNyaC+JFdy4287A4nrSTsd
         +H28kgC0BZCbk33WAscApM0Jeq3/NNLS3Yq+xkqGpGXwOYDdXG893FpVcSvMyN+FZWA/
         /BaPYtnARIq7+BViM01rjf1T7h676rKlgCWMhn/lHs40kzezxao9sSK2MAl2hugZFjJw
         JdsA==
X-Gm-Message-State: ACrzQf1iWJwsHEItI3gjNQKHM7ZdkJQG4pxYXIOE26GfSY334HkFGuFz
        eosMDd2qz38bb0n98BnvY1Y+qn9Ke11yLbowWdrB7g==
X-Google-Smtp-Source: AMsMyM58rQ+3W7cjTjvM8lThVWn9iA3CBttiqPa81bN4d9JXmcuY3Zl83chUpyB15+SM2jaUUuvYqMwX0McAWR3Jg7E=
X-Received: by 2002:a05:6e02:b4d:b0:300:b1ee:c17e with SMTP id
 f13-20020a056e020b4d00b00300b1eec17emr1778319ilu.101.1667226092159; Mon, 31
 Oct 2022 07:21:32 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Mon, 31 Oct 2022 15:20:56 +0100
Message-ID: <CAG48ez3a_35R48khgW8D1MxokEqmYP3mBsUwhMq5Vfi5BiyYCQ@mail.gmail.com>
Subject: [BUG] AMDKFD: criu_checkpoint() error path treats userspace pointer
 as kernel pointer
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
        Felix Kuehling <felix.kuehling@amd.com>
Cc:     David Yat Sin <david.yatsin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

be072b06c73970 ("drm/amdkfd: CRIU export BOs as prime dmabuf objects")
added an error path in criu_checkpoint() that (unless I'm completely
misreading this) treats the userspace-supplied args->bos (which was
previously used as a userspace pointer when passed to
criu_checkpoint_bos()) as a kernel pointer:

  ret = criu_checkpoint_bos(p, num_bos, (uint8_t __user *)args->bos,
      (uint8_t __user *)args->priv_data, &priv_offset);
  if (ret)
    goto exit_unlock;
  [...]
close_bo_fds:
  if (ret) {
    /* If IOCTL returns err, user assumes all FDs opened in
criu_dump_bos are closed */
    uint32_t i;
    struct kfd_criu_bo_bucket *bo_buckets = (struct kfd_criu_bo_bucket
*) args->bos;

    for (i = 0; i < num_bos; i++) {
      if (bo_buckets[i].alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
        close_fd(bo_buckets[i].dmabuf_fd);
    }
  }

This seems very wrong, and also like it's guaranteed to blow up as
soon as it runs on a machine with SMAP, which makes me think that this
codepath was probably never exercised?

(Also note that just changing this to copy_from_user() instead would
still be wrong, because malicious/bogus userspace could change the FD
number to the KFD device's FD, and the VFS assumes that an FD can't be
closed while it's being accessed in a single-threaded process.)
