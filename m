Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1835EF5B5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiI2Mt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbiI2Mtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FAA4BD36
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664455788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IyvAXBczFokO0b56jpD+DUjX6Pkc7ql0K+hq5adeAA4=;
        b=JdYDXM8tIAZeJywymWeOM2/Yi9swXp40THc6H9KZaFuWa7jwLfytWqrL1mvvfy+V+BGRyQ
        Idt0n6X7keVAcdb++sWMLxSp05CmrQW7u7OpSi/ETNNEHVgBSmawdfRjjXKKIqzkvXQUeJ
        PTsh5/O19EhvfyNPjvgTAHqsor8gb2o=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-64-5mzu7nZBOw6WaNKB16WevA-1; Thu, 29 Sep 2022 08:49:47 -0400
X-MC-Unique: 5mzu7nZBOw6WaNKB16WevA-1
Received: by mail-pl1-f200.google.com with SMTP id h11-20020a170902f54b00b001780f0f7ea7so965513plf.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IyvAXBczFokO0b56jpD+DUjX6Pkc7ql0K+hq5adeAA4=;
        b=pEK1EHMMr114e4sUzFOX2SdwIo5YCzP2mn+ww1OBbFLjUepJv8pdQ0njngCL9u3kh+
         mkiuhbCgPfZAzHNFFdD8TitOT0kIa+p1NGihAsjLvvDSqwDUOK6EIrN2F3ezJDD6RxqA
         Xt4uiehzLdjH+jmRZ1f7b+ZTfvAslRKkr82Ot0Q+kRZjZ4luCRg/XHXiYTOJlZmmwnUd
         RcmMPKtatSSxYpmJ/qew3Wgr6dHVCUHCYUQUQZCkjN6wLLJpC38ujkWfKXYxTyOK1iTj
         IiUgQeIfrqITbD5F2g1lCapu3u14pWwLS3/xNLUt/+mq9lH4fPuUGm/4ELD8T/DT/wjO
         A4nQ==
X-Gm-Message-State: ACrzQf3SY25MqKdhpnu/pNp0N2XHx0LpU9iRSmfYd8eCtYWj8xMhPrgo
        v8p6XTXf+1ZOoJZKNmk+EZ+ox8owl7aqrJ75xPkUgeiFTo1qLmW9YW8kmN4AG+2kADjfCXUyH2/
        rzULJG6QdCFz+8pGTo0jHkHDBlYcEtHO7jS11hOQI
X-Received: by 2002:a17:902:d88b:b0:178:264b:5aa4 with SMTP id b11-20020a170902d88b00b00178264b5aa4mr3327486plz.44.1664455785638;
        Thu, 29 Sep 2022 05:49:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4pDEQm853od9uXDxyzSQp9FIOigyMNiHHv2cBX1TiTmWCSnLC71eEUMDfN/FGECMntfwvdjdoIBt+QbexJOT4=
X-Received: by 2002:a17:902:d88b:b0:178:264b:5aa4 with SMTP id
 b11-20020a170902d88b00b00178264b5aa4mr3327473plz.44.1664455785337; Thu, 29
 Sep 2022 05:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220924152227.819815-1-atomlin@redhat.com> <20220924152227.819815-5-atomlin@redhat.com>
 <CAOr2xH5DjEy7agHYx=5+4cr+OeJz52HUeUttkF9ueS8JHbQMFg@mail.gmail.com> <20220929082216.vbkyzbxhsq2ixjdm@ava.usersys.com>
In-Reply-To: <20220929082216.vbkyzbxhsq2ixjdm@ava.usersys.com>
From:   Rafael Folco <rfolco@redhat.com>
Date:   Thu, 29 Sep 2022 09:49:33 -0300
Message-ID: <CAOr2xH7mitckRF8_8wE9aDZuG2M2YCAH0-NUweY3Z6Bt3KwNqA@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] tick/nohz_full: Ensure quiet_vmstat() is called on
 exit to user-mode when the idle tick is stopped
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     frederic@kernel.org, mtosatti@redhat.com, cl@linux.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        atomlin@atomlin.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, please do. Thanks!

On Thu, Sep 29, 2022 at 5:22 AM Aaron Tomlin <atomlin@redhat.com> wrote:
>
> On Tue 2022-09-27 13:17 -0300, Rafael Folco wrote:
> > Tested this patch w/ nohz_full setup and oslat 8h run on isolated cpus, max
> > latency is 7us versus 15us without the patch.
> > Thanks.
>
> Hi Rafael,
>
> Good news. Thanks for the feedback.
> May I add Tested-by: ?
>
>
> Kind regards,
>
> --
> Aaron Tomlin
>


-- 
Folco

