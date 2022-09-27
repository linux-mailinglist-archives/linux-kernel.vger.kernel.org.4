Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C05A5ECBA6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiI0Rub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiI0RuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:50:04 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFF380BDC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:49:04 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id y9so5468428ily.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=aH5zY6y4AfoLNMJw/j/1E8ilTfiC2ZGSCFZ+mICKnl8=;
        b=hjD82U6QZ7vWgB3aKUqxIHx7uLRDY+PcY/enPg2cqnqmZKGLg4UhLPDXuZUQ6qwhZW
         qfLu5LSwOMwVVD2uSOk7Iswfy6MJfHCd7IUHXvNmD2astnQzod0kSvrvsjszWrJQIiUn
         8HEuA9jyZX/DB95xq2FOExGaCSjljxjNeIaeOgq6mOXTq5guJsCvo0+B82B/AmO3BWG/
         HxeuIWKqNAsMmoDcjS9ER3j0EZkomrD0ZSPKVGqo3V8Q4PG41UGwDovBo7hIYwstXQyH
         MVnEN9crkiX4tRX4a4lekaK9IXHW7M4I9z/UQIt0JaCZz2qtANOK2mfmenzAjWc/i6xO
         BcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=aH5zY6y4AfoLNMJw/j/1E8ilTfiC2ZGSCFZ+mICKnl8=;
        b=1lej7gTrNQO7QG3IWC138lsqFwKu9ocYn3OjgjBzbfqbikNVDHYjW+DSphdeBGvqlR
         3QNGETkYn4Cgaa1eFwy9hiaSwn3dEyHf5sE5ox4CPPIeQ4h4wY8gddMXr6eLQApwl8V2
         hc9Vjn3e7bW0k6107cUDcvC18Qz2BXpYjyqEsNRvwYPHk8MgXC/DH+EUnMNxK876L2dj
         CeDO96LMNW5WhkRakKxXJrsYrVJEsCGo85jYf4MNQ1ZQa3DKG1aIskO2R58UxBMYgQ7P
         hLpsNNDzjdeAI/CEHBV91a4gW3cNlYA7XQCxuzDt3x0D9NKgYQiZ/5Y9B1PmBJaLzRYC
         No/w==
X-Gm-Message-State: ACrzQf2f8nLYo1MhN7KA+ujR3TlhxockQXaVUlM0z+epZwXTD1dQZt+f
        3LEHQpqXvPu0rEyQuAvksteAzgHtD8PgcZKdopQ2IQ==
X-Google-Smtp-Source: AMsMyM4WSdgcs3053+4q6G+gKJ/OL8h98odCYYex/ySfuvKuvzP9K3W1FYm+E0hfdBtdE3gYPJCBVhXItsWGJJe5ZGg=
X-Received: by 2002:a05:6e02:1bcc:b0:2f7:2d36:36b1 with SMTP id
 x12-20020a056e021bcc00b002f72d3636b1mr10950913ilv.240.1664300943591; Tue, 27
 Sep 2022 10:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220927002715.2142353-1-mizhang@google.com> <YzKGqLzjv0I/gkMi@google.com>
 <86zgel6rz8.wl-maz@kernel.org>
In-Reply-To: <86zgel6rz8.wl-maz@kernel.org>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Tue, 27 Sep 2022 10:48:52 -0700
Message-ID: <CAL715W+gJKH+3xgFzUjPs6SAMwZCzkF5NNOTDpa4ov2qZ3r_iA@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Cleanup the __get_fault_info() to take out
 the code that validates HPFAR
To:     Marc Zyngier <maz@kernel.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>, LKML <linux-kernel@vger.kernel.org>
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

>
> Honestly, I'd refrain from such changes *unless* they enable something
> else. The current code is well understood by people hacking on it, and
> although I don't mind revamping it, it has to be for a good reason.
>
> I'd be much more receptive to such a change if it was a prefix to
> something that actually made a significant change.
>
> Thanks,
>
>         M.
>
Hi Marc,

Thanks for the feedback.  I am not sure about the style of the KVM ARM
side. But in general I think mixing the generic code for ARM and
specific CPU errata handling is misleading. For instance, in this
case:

+     if ((esr & ESR_ELx_FSC_TYPE) == FSC_PERM)
+             return false;
+
+     if (cpus_have_final_cap(ARM64_WORKAROUND_834220))
+             return false;

As shown it would be much cleaner to separate the two cases as the
former case is suggested in ARMv8 Spec D13.2.55. The latter case would
definitely come from a different source.

But I also don't have a strong opinion pushing this one. So, let me
pull it back then :)
