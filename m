Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B4E5BD200
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiISQRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiISQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:17:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A87713F77
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663604234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xn5fnqKtyryYA5w5sfE3wIiUTcmcdDi6qpfcSbkJ4Lw=;
        b=fL75oB0UK/7xkFg/t9YdFFr3UKA3fT0on11Ga9ay9FnKJC9VzHCNXk0cxwSoSK5iF/mNwu
        tR58Am+aMuTM1v0HyAjzog/SErZImJawuxLY2I+p6Kaj18+n9uEVrmNfSf8kkgVu7Ty51e
        ZDe2l0yQ/yDDDt/c6zjsOX1p0DeUYiQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-618-leChdT8yNvqL75bh3tAKCg-1; Mon, 19 Sep 2022 12:17:05 -0400
X-MC-Unique: leChdT8yNvqL75bh3tAKCg-1
Received: by mail-qt1-f197.google.com with SMTP id s21-20020a05622a1a9500b0035bb9e79172so15583993qtc.20
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Xn5fnqKtyryYA5w5sfE3wIiUTcmcdDi6qpfcSbkJ4Lw=;
        b=ngLczfNUjJsbZba1+AvaECYriYRFRTMxaDPV7xdvL3lfpFq1fiyteRSs/JLnuVWvrz
         FeKUT0nXQepS+znELDmHsPKBImoQy1388P4QaEZcSKC7737EQYHLAaeG0NIoNk9EkUYY
         ATetvYxp0BMMrgcHhfNZ5182zQk4XlQNL3fMrs/d2huHR7gkX6Tu+qN3XCWXy2vUAFDB
         71lx1QNkphJn4YLz8dVckmOczjRIBhw2GjNNMSvR5eqWszry8uE4AZk1V9pnsPvAED/+
         ItmmXO7xo9WkDk0Bda52SNoM0yMlI0kNhQdUrXAPUUEXBsxsPbaACLVYDh408Ea3XZFw
         XfFg==
X-Gm-Message-State: ACrzQf2wjBcI/+zi/6p2ho1HFhjyYYJt133DnP4NPVE94nNfkCcfYA01
        6scovIY/kv8+cX5yWn5cyiWRfxeDExARtVKWxFNGKjjuzvSSgzj09CTl1rliR3rMUCdTmHbFMSl
        fHS5BwQsUTZO8HNEH4VxGaduG
X-Received: by 2002:ac8:5e0a:0:b0:35c:e8d8:6c19 with SMTP id h10-20020ac85e0a000000b0035ce8d86c19mr5068663qtx.178.1663604225349;
        Mon, 19 Sep 2022 09:17:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM51+LmYDmB5JjErlr4hYbacMbbiBwggTg81wkAjJVlWGP8agHsUu4S5cY7WS6QJw0cvQ6qJIg==
X-Received: by 2002:ac8:5e0a:0:b0:35c:e8d8:6c19 with SMTP id h10-20020ac85e0a000000b0035ce8d86c19mr5068640qtx.178.1663604225144;
        Mon, 19 Sep 2022 09:17:05 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bv12-20020a05622a0a0c00b0035cf2995ad8sm826570qtb.51.2022.09.19.09.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 09:17:04 -0700 (PDT)
Date:   Mon, 19 Sep 2022 12:17:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        catalin.marinas@arm.com, linux-kselftest@vger.kernel.org,
        bgardon@google.com, shuah@kernel.org, corbet@lwn.net,
        drjones@redhat.com, will@kernel.org, zhenyzha@redhat.com,
        dmatlack@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        oliver.upton@linux.dev, shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/5] KVM: x86: Introduce KVM_REQ_RING_SOFT_FULL
Message-ID: <YyiV/l7O23aw5aaO@xz-m1.local>
References: <20220916045135.154505-1-gshan@redhat.com>
 <20220916045135.154505-2-gshan@redhat.com>
 <YyS78BqsQxKkLOiW@xz-m1.local>
 <87illlkqfu.wl-maz@kernel.org>
 <a2e0b9bc-2c67-8683-d722-7298bd65058c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2e0b9bc-2c67-8683-d722-7298bd65058c@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 09:58:10AM +1000, Gavin Shan wrote:
> I think Marc's explanation makes sense. It won't make difference in terms
> of performance. We need to explicitly handle barrier when kvm_test_request()
> is used. So I prefer to keep the code if Peter agrees.

No strong opinion here. I keep thinking clear+set look awkward even if it's
unlikely path to trigger (ring should be recycled when reaching here for
any sane user app), but if it's already 2:1 then please go ahead. :)

Thanks,

-- 
Peter Xu

