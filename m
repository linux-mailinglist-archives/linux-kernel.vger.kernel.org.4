Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A926D43C0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjDCLmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjDCLmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:42:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654FD5B9A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:42:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y4so116181128edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 04:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680522168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kJQgC8vpBuUWGJhcmSIUYP2ioIg7/McJ6PvsYtiX0TE=;
        b=iDYAFPmDRwMU+VamA8pIZ58oU63tZjtvtsecrSIUt+oBtbA8KN8HVQcvNAAsiFefSf
         LX5kinSZHaHt3C7yD5JwIdxnrq6ta3wG7lrzniX35KmYnPelrcWZVdIYANXRZdnR9WLr
         6yiGkovJf0+3739Jh0AcDgGDdvEl+cr9KKyyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680522168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJQgC8vpBuUWGJhcmSIUYP2ioIg7/McJ6PvsYtiX0TE=;
        b=hRfg7W6Lche2IMJmoO3Gp8OolLsEhKSXQt+Wq4tZyzr6/qyr5o5m4XW9EHZjm7dCEr
         ihA64glfk5HhYava7leYi6gyb0CNu7o4soDKuwrOnwKz5710gi4N0FaDMddtuaq2zuzO
         1emSi3zWn14aYl28kDsNIoIcKtB3V5sc2MVJeQlH07JFzSZQRw6AoafV2cEZ7RfFSukB
         86RVSG5jmSX3VvEZDB7OFhvitm+75ok1T/6fVO2iC+ouJzQES7oDOuMTy9Z8s33Rb+S0
         kDbo+MwvaxuZTJNqKKei9W/Ss/kw1l5kzqy/FcILLrzGwejnmrwpWW45TiuDf0lt+MvR
         FD5g==
X-Gm-Message-State: AAQBX9f4oIbsX7GyyWbtGY3iUQwTbxBwBbGPj2nOxFU2OePhchvqYbsy
        EPEpRlrmVf13PIHfNFI1taZZbc5bYcrKgUrhm0PFZw==
X-Google-Smtp-Source: AKy350YiUmrIhgS3KRvmZNctbR+6CUC0vQUYvXEn75Ib+anyPhlAs65KH9rxI+jaGGrCT7L9bwrs9se7qF1/+y3voyw=
X-Received: by 2002:a50:9e8e:0:b0:4fa:4bc4:ad5b with SMTP id
 a14-20020a509e8e000000b004fa4bc4ad5bmr18336974edf.6.1680522167955; Mon, 03
 Apr 2023 04:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230329180502.1884307-1-kal.conley@dectris.com>
 <20230329180502.1884307-5-kal.conley@dectris.com> <CAJ8uoz1cGV1_3HQQddbkExVnm=wngP3ECJZNS5gOtQtfi=mPnA@mail.gmail.com>
 <CAHApi-kV_c-z1zf9M_XyR_Wa=4xi-Cpk1FZT7BFTYQHgU1Bdqg@mail.gmail.com>
 <CAHApi-mp7ymJ2MP_MFK=Rcv--YCz4aqtKArMwF1roRZHh0to1A@mail.gmail.com> <CAJ8uoz25jnBtaKZQ7SbJ_fdihiQTfN_AAtOuB4v-g85SS7QM5g@mail.gmail.com>
In-Reply-To: <CAJ8uoz25jnBtaKZQ7SbJ_fdihiQTfN_AAtOuB4v-g85SS7QM5g@mail.gmail.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Mon, 3 Apr 2023 13:47:28 +0200
Message-ID: <CAHApi-kNzh1v7O9thi+2epqitE8pjFOn0tTLD1q8GyRuS9JH8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 04/10] selftests: xsk: Deflakify
 STATS_RX_DROPPED test
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #2 is also a bug fix in my mind, but not #3 as it just adds a test.
>

#2 is a bugfix, but if we put this on the "bpf" tree already, then it
will make a problem for later commits that depend on it which would go
on bpf-next.
