Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561536E2694
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjDNPNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjDNPNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:13:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8537A5CE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:13:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a69f686345so1574745ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681485181; x=1684077181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7E15TZKBUj7LhKJ72c7EvYGt3lCtMNYU30GwoWvGVWc=;
        b=SwfEYPmd8IRm9u4LIVjSicWRhIutWoRBZqFRWlvcMNDlssOMFULhbOGPAqWwmiVri5
         CmWC5762Km5wIjFXpzI6QjxUGpWMfxzcUPdOgnfdExMTlDRL3aXRXr9rEK0AD5peGYzY
         GLvGqSGHGLfUzRYt/7RNrnu0Lv1LMvCvDeOY6Mu5NiKjHGFY64g9YsEiw6tFaV5ICZtA
         HYN+Foop8qrpcko+chagArltME3j6R+/RxbkwDGEPuJGc0uBEWS6l86SOH1D9RBlWo8h
         kaTtkJT4CIqZM9O2sbyqYdeegGdZCAAe5SiJswLnWn37HhjAZ9zVVeb9gbN9mowhBmoF
         ttXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681485181; x=1684077181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7E15TZKBUj7LhKJ72c7EvYGt3lCtMNYU30GwoWvGVWc=;
        b=FH6GZToyXFir+vXnAlduXQPqH+YG8DWxJlnVc2csHJJ3on1mPYI+5ImI+jA2PEFVmz
         Mus1YYp9A0uFxPA2wgygsyYQR1dCUk4tksQIdUxrx9j63Pult6HM002ym8ugX++4C/HB
         nPWI0swvSWkR2JVsnMmtt0PgxJTdrfNyovTAbPkwWzcplro6xUwsxoeDX9Z/Hkd/5Ojq
         QVBgLR0XXkIaY2lsGfuXcsnDUdWy8Q17q2TPU3VZ34iMJtk6qDHPDL6UJLXJr57+7vZH
         vJyBKjSqkeq645JpnDdYq4JcMHs5qPCnEueTaEtKsrtue2U1qdynMaCfrj0a/RgQ7wfZ
         egOA==
X-Gm-Message-State: AAQBX9chUakPXauAifrP/OBzpLP427pz/nEECGUwvdJQu2fe2um86S/W
        iQhbJFHPvoq6siqNAUL4i/Lo9UMjUJmYi7QtnHlY/A==
X-Google-Smtp-Source: AKy350a/j8gjvHx5XSjNdD1sExInjJAJ7u6ERNSyq4ejXK3n0tHMQ777nwe9LmVp5aHRdXJu3Y85pw==
X-Received: by 2002:a05:6a00:2e1d:b0:636:ea6c:68d8 with SMTP id fc29-20020a056a002e1d00b00636ea6c68d8mr8600263pfb.27.1681485181079;
        Fri, 14 Apr 2023 08:13:01 -0700 (PDT)
Received: from [10.255.185.5] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id 5-20020aa79105000000b0063b1bb2e0a7sm3129352pfh.203.2023.04.14.08.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 08:13:00 -0700 (PDT)
Message-ID: <65f424ca-d7cd-f53b-cefc-684ec0393bce@bytedance.com>
Date:   Fri, 14 Apr 2023 23:12:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: Re: [PATCH V5 5/5] cachefiles: add restore command to recover
 inflight ondemand read requests
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com,
        hsiangkao@linux.alibaba.com, yinxin.x@bytedance.com,
        zhujia.zj@bytedance.com
References: <20230329140155.53272-6-zhujia.zj@bytedance.com>
 <20230329140155.53272-1-zhujia.zj@bytedance.com>
 <1250439.1681480404@warthog.procyon.org.uk>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <1250439.1681480404@warthog.procyon.org.uk>
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



在 2023/4/14 21:53, David Howells 写道:
> Jia Zhu <zhujia.zj@bytedance.com> wrote:
> 
>> +int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
>> +{
>> +	struct cachefiles_req *req;
>> +
>> +	XA_STATE(xas, &cache->reqs, 0);
>> +
>> +	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>> +		return -EOPNOTSUPP;
>> +
>> +	/*
>> +	 * Reset the requests to CACHEFILES_REQ_NEW state, so that the
>> +	 * requests have been processed halfway before the crash of the
>> +	 * user daemon could be reprocessed after the recovery.
>> +	 */
>> +	xas_lock(&xas);
>> +	xas_for_each(&xas, req, ULONG_MAX)
>> +		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
>> +	xas_unlock(&xas);
>> +
>> +	wake_up_all(&cache->daemon_pollwq);
>> +	return 0;
>> +}
> 
> Should there be a check to see if this is needed?
> 
> David

I've considered whether to add a check here, since the user could invoke
'restore' through ioctl at any time.

If 'restore' is called without user daemon crashing. Then the req being
processed by the user daemon will be reset to CACHEFILES_REQ_NEW and
could be re-read and processed by the user daemon.

For OPEN req:  The user daemon will ignore this repeated req since the
related anonymous fd is the same.

For READ req: The user daemon will read the same part of the data again
and write it to fscache (this will not cause any error)

For CLOSE req: Actually the user daemon will close this anonymous fd,
but fortunately [PATCH 3/5] could handle this case by reopening it
automatically.

Thus "restore" could be called at any time without error, checks
might introduce extra race conditions.

Jia
> 
