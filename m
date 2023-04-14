Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC34B6E2733
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjDNPpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNPpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:45:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5095C26BB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:45:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z11-20020a17090abd8b00b0024721c47ceaso5056701pjr.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681487132; x=1684079132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gutJ4yAe/JkNa5xIKaFp+nwMYRP6dEdLjl9hZY/uZI=;
        b=PvGDFGLreO1q29h5tvBQs9H97oRCot38LOJh2IXEjgQ1nEd+yKU3UIVeo6ofc0d+kG
         FgA+wfySoF9yjy32yIJRizWd8XCsL4YQUznFpKGhUFi7H2AX7h0phxaynMRPwJ1G+G0n
         dycW07AIRpiZL/osBuPHuLRx/P/fqstRX6xwn9k/VC7zaAy2OCYOYW7LyUnTmHBhwill
         XOsGXVirvJdQaZvAPTlXlSTaLwgq2u2WL5qju5Mw/3cIFlCZaGdNZoR15DHQqDuK1kOc
         pmZGKVv7QSc1yL3ym+iRg54SnkL2RhSrOaTqJkEh5jvYJ9ofCnGltHz8WIlCte/CveuE
         WP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681487132; x=1684079132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7gutJ4yAe/JkNa5xIKaFp+nwMYRP6dEdLjl9hZY/uZI=;
        b=Jj3Kv7+7mPz0Nhm+AwCYteD3T5lzYAPtWvGkFMclbQC8NL9P0OX034NRkgxRc1p7BP
         p370gXN2LmzRlet99lu+cxn+CTlpaIJDERL9pdLncpB/18l1IJ0DPzHopJ9HTJNOyem1
         gzLEmCLgC5dmU+mF+cVohExLWfgUbBEgUBJPHFsU0TOaB6dSF/sR0+XBVP4OCfVftsxq
         nB5BLeAUBC+UirAVsnMwxP2IjLPOQGlo9/bf+P0th6WI2tDrJA7Lm2gYm0Nb/JCUjzvS
         PIdLLoqcetZvkimOFaauI/mAlYeeBAvr+P62BAkx9b2YHOZtG6mS4k5Dayz+8Qx+i3zd
         o0fg==
X-Gm-Message-State: AAQBX9eriahyswqJ0yVjHxqCDpPF4TJ9SHaNr/KsONFstuy3oPXjUl7f
        93Z2WHuGx5et0QQZd7FYIUQmDw==
X-Google-Smtp-Source: AKy350Y7T+7xKTE2jnOyKS8B+OM1XJANTVOkZ6bFQpjwSG5ySowVYCk/VmCO7z52L/JBVLB93/WFng==
X-Received: by 2002:a17:902:e801:b0:1a6:4714:5cb2 with SMTP id u1-20020a170902e80100b001a647145cb2mr4074836plg.2.1681487131808;
        Fri, 14 Apr 2023 08:45:31 -0700 (PDT)
Received: from [10.255.185.5] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id g21-20020a170902869500b001a5260a6e6csm3201794plo.206.2023.04.14.08.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 08:45:31 -0700 (PDT)
Message-ID: <c310a5e7-e410-dbdb-cada-3eca82a9ceb0@bytedance.com>
Date:   Fri, 14 Apr 2023 23:45:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: Re: [PATCH V5 2/5] cachefiles: extract ondemand info field from
 cachefiles_object
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com,
        hsiangkao@linux.alibaba.com, yinxin.x@bytedance.com,
        zhujia.zj@bytedance.com
References: <20230329140155.53272-3-zhujia.zj@bytedance.com>
 <20230329140155.53272-1-zhujia.zj@bytedance.com>
 <1250339.1681480291@warthog.procyon.org.uk>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <1250339.1681480291@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/14 21:51, David Howells 写道:
> Jia Zhu <zhujia.zj@bytedance.com> wrote:
> 
>>   #define CACHEFILES_OBJECT_STATE_FUNCS(_state, _STATE)	\
>>   static inline bool								\
>>   cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *object) \
>>   {												\
>> -	return object->state == CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
>> +	return object->ondemand->state == CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
>>   }												\
>>   												\
>>   static inline void								\
>>   cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
>>   {												\
>> -	object->state = CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
>> +	object->ondemand->state = CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
>>   }
> 
> I wonder if those need barriers - smp_load_acquire() and smp_store_release().
> 
> David

There are three object states: OPEN, CLOSE, REOPENING.

Here is no logic in the code such like: A has to watching and waiting
for B's status change.

And so far I haven't constructed a scenario requires barrier pairs. Thus
I didn't add barriers here.

Jia
> 
