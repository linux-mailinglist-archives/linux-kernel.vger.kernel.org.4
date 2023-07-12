Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760C5750A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjGLOKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjGLOKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:10:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC66F1BE2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689170980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5uBD/TLKxMpe+p//1j488kdQHXM5BJhX5ouQYLZ53s=;
        b=DElNlv93sMDZ6OnHnv4vXhFBq8u/0/pI5ZH9E21TjqTujcc7cvo2P7klwH718Qip6nhAZ+
        fMTb/B/F981UJACepmF3Jqyjy5YpY8rjLJ/GpgwVuirObAL/CJEMK+/4jXTqLhXFqC7xTS
        MT3ZV1bf1T6m3Dk3lfN6+Y1WnWt59+Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-R_KOoiSLNBmHDiozqDKy2Q-1; Wed, 12 Jul 2023 10:09:33 -0400
X-MC-Unique: R_KOoiSLNBmHDiozqDKy2Q-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6372702c566so65420436d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689170973; x=1691762973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5uBD/TLKxMpe+p//1j488kdQHXM5BJhX5ouQYLZ53s=;
        b=AYuQS040lgfgd62sXfbW3HIrk6Kp5gFYeH2zqBMQVoQTIjZodLlVhH1JNYrJLcHk/A
         cirHj3px6+DGI8GHNE+5srcqjywzHAA6/OmA6BOAmh9SEZa000RwAmZQ6CFMimXj7gYk
         phViJDzBTPiN1j/0CBMBb+09VieX1YofTaISGQQZzn4c+sLIzQEv5RzJdpFpBVsi5uYe
         /c1xjyvAbasfpIUmuidsqS2KzIx+H4BXZR3eez5aUJjMskLasDDDtd4kmGL1g5HfISHr
         81e8jDqsHBKU1FpolV+Fr20QUNI7kg4+uI0c4vePOLeZsTb2slzwktG0p5bzHDewNa/p
         GaWA==
X-Gm-Message-State: ABy/qLZQg/d2zNmWtgdIW+07CeL2YOqdgyowgxOx5m/PTWkWdWcO4YgO
        LG9+ucNR0THNPRRV9mee1+/o2np7ui3sSE0Pz7/ESFu56YLKqL05QdDMBA9EtGLgBN2LVSiL79Z
        oy19zLnCBJ4xCwYwHnOfOZOPA
X-Received: by 2002:a0c:dc0e:0:b0:635:f4e3:8842 with SMTP id s14-20020a0cdc0e000000b00635f4e38842mr16067558qvk.48.1689170972737;
        Wed, 12 Jul 2023 07:09:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFa7QPSkaA231ENAeq2sy1N45YpziMICNrJlIgJ1HhKyOxfduwV8ke58D7Ri08XH4dEocGTJg==
X-Received: by 2002:a0c:dc0e:0:b0:635:f4e3:8842 with SMTP id s14-20020a0cdc0e000000b00635f4e38842mr16067543qvk.48.1689170972501;
        Wed, 12 Jul 2023 07:09:32 -0700 (PDT)
Received: from thinkpad2021 ([64.99.149.73])
        by smtp.gmail.com with ESMTPSA id r7-20020a0ce287000000b006255bcfca88sm2245860qvl.7.2023.07.12.07.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 07:09:30 -0700 (PDT)
Date:   Wed, 12 Jul 2023 10:09:28 -0400
From:   "John B. Wyatt IV" <jwyatt@redhat.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Juri Lelli <jlelli@redhat.com>
Subject: Re: [PATCH] x86/microcode: move @microcode_mutex definition near
 usage
Message-ID: <ZK60GMfVv4UXsejE@thinkpad2021>
References: <20230324114720.1756466-1-john.ogness@linutronix.de>
 <20230324120019.GAZB2Q09ODVq0iYz5l@fat_crate.local>
 <87edpenvkh.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edpenvkh.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

I am a new real-time kernel developer. I am still encountering this with
the linux-rt-devel repo and need to apply the patch manually to build.

On Fri, Mar 24, 2023 at 02:17:10PM +0106, John Ogness wrote:
> Digging deeper I see that initializing @wait_list in
> __MUTEX_INITIALIZER() is what is allowing unused global mutexes to go
> unnoticed. Since with CONFIG_PREEMPT_RT the mutex is different and
> initialized differently, it is (correctly) detected as unused.

As far as I can tell @wait_list has been removed from both torvalds and
linux-rt-devel's tree (it is still in the comments).

What would be the next step in getting this resolved?

John B. Wyatt IV

