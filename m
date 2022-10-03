Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9A85F3464
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJCRXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJCRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C63B2F00D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664817796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZcKEyglz2TbKS11RyS2nvN0KWcDU1wuM3YnwQLNBo2g=;
        b=YKAyUB/9ozIzUzi3ALX2Royk4yChuVEONBEegCs4W1TOmraTGWhrnPqBUEMMRPCOAUYJmU
        JnVFMwdW7x0B6P2Hl4a4lQTz6vU9d/l3J6+/gfUj9croIpuPShEIfY0Rn39m3RXVLDqjvs
        /8z/QKV9Ig/6qa/KHoALdtHbrANavwg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-IPFHjHP-P_WuE7xlc09qVQ-1; Mon, 03 Oct 2022 13:23:15 -0400
X-MC-Unique: IPFHjHP-P_WuE7xlc09qVQ-1
Received: by mail-qk1-f199.google.com with SMTP id az15-20020a05620a170f00b006cece4cd0beso9673334qkb.22
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 10:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZcKEyglz2TbKS11RyS2nvN0KWcDU1wuM3YnwQLNBo2g=;
        b=ABD+Oaj4kdpVLv9clm+CKIvDQ8fW7I7YcfMgvbIJaEe8KbAUjwYo/jita5DnbqMCgs
         zpXoRuZNA3SjNLcqwZ0/769wnVPhB9H71TQQC5GuKD2vpE7ZYEHhqhht3VVoETG5/UOi
         fzq8FzqLnTcSFso/VpsVlfw2OjKlrIUwRxby4uaaZwT3XVlS/VhzKJALGTKl5qZqDVzx
         dBakhamdmCnlTKtJyoLwZHKP/AKUY+VgC4hJJol5P8I1srwP7X9ohFZQnXJfk/f+gVjY
         bSK4/1pHjs5JDExsNXj6uXVzxpAxCb9tHuJfD3sa7H8ipTNPS4Ke25rG5QuLnzlMj0hP
         xnkA==
X-Gm-Message-State: ACrzQf1FROYq0IgSDn7ew50ZfB+D7fowCv77oLuVw588pSHAln+/VjW7
        qYQgL2ntDkwMonPaVI7VlB93xmdIwxOZflsP8T1HQjAbhBRoDY9r4fhITjFdh5uZbhOOq7tZFws
        +IM5kzVyXiQQ5mFgeMk4sAI1P
X-Received: by 2002:a05:6214:f0b:b0:4af:9262:d52c with SMTP id gw11-20020a0562140f0b00b004af9262d52cmr16854204qvb.57.1664817794960;
        Mon, 03 Oct 2022 10:23:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7qcgzaUWumDfu5NTpxrYh6RI2AyvoF+HtSaDAGCLvDxpVt/UGtXGzaAVXPuKw1Kj+/faZGHQ==
X-Received: by 2002:a05:6214:f0b:b0:4af:9262:d52c with SMTP id gw11-20020a0562140f0b00b004af9262d52cmr16854184qvb.57.1664817794750;
        Mon, 03 Oct 2022 10:23:14 -0700 (PDT)
Received: from localhost (pool-100-0-210-47.bstnma.fios.verizon.net. [100.0.210.47])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a284c00b006cebda00630sm10429201qkp.60.2022.10.03.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:23:14 -0700 (PDT)
Date:   Mon, 3 Oct 2022 13:23:13 -0400
From:   Eric Chanudet <echanude@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: qcom-ipcc: Use generic_handle_irq_safe()
Message-ID: <20221003172313.vv3isog3nsc3r2pn@echanude>
References: <20220909162043.2734873-1-echanude@redhat.com>
 <YyBP+eNIBCN0OsGt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyBP+eNIBCN0OsGt@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 11:40:09AM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-09-09 12:20:43 [-0400], Eric Chanudet wrote:
> > PREEMPT_RT forces qcom-ipcc's handler to be threaded with interrupts
> > enabled, which triggers a warning in __handle_irq_event_percpu().
> > 
> > Use generic_handle_irq_safe() that can be called with or without
> > interrupts enabled instead.
> 
> wouldn't IRQF_NO_THREAD be a better match here?

Agreed, my apologies for the delay:
https://lore.kernel.org/linux-arm-msm/20221003170849.383005-1-echanude@redhat.com/

Thanks,

-- 
Eric Chanudet

