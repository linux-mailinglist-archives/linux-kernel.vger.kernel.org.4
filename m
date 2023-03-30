Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084626CF9A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 05:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjC3Dok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 23:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC3Dof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 23:44:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD5C4ED5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:44:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l7so16045811pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680147850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQ0aOCOIHslwWeAUgUUQoRMNFdlJZ0p6oA7JcNsWsx0=;
        b=L+8iXJz7z6DpLY76k9YnkTN+Ng1+Vo9mPB+jC9SB7IjpmO3LMz4Hr/y+fOU2kxrSt+
         FUo2gaKnDsMwgrl42/7xi6Yh+80sOsLnGQJlkHW+UPYCjEkmPHWYkKn8ogJI9VoOckZJ
         yrZpbVrjX6iGVQySm59jzoash/p2C9KrcCptCZc0zcHSuynZrzsdJC3UkneRyzFsHpvK
         u1IyUNlALDXTxlvVbFCXDRHn4hJ9weygOneNpN82Hl3Ctb2woSJG/q263FQVbML4agrV
         +xxlKgb39kkYVwtYjxa+462WbzaSUeTkMecADWk1CVDYOUOHJms1FgGXJ0vQBnFwn6nH
         fU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680147850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VQ0aOCOIHslwWeAUgUUQoRMNFdlJZ0p6oA7JcNsWsx0=;
        b=Vno7xL3a0jB7zNxUQ7UroKBhTfeY8RuL74f1tsSVBUPn8co63E2Nt5T5dQ8aYZsZ6+
         fuQcwZe1kzJVUxsQbx/QasDlyaJr9NjQDzKW1QfeWJAIQCLdkcD4jPWW9K7nraZi3rvw
         Zmo94jnHSVcx1WKNzrjmrEcZl/ytvzGzaLWxfLQO2naNTLsM2mgUXhK/ki9rDV296BDg
         bGAGKQAP184JeVc4/YXYml5IOKkXndyTnxJTkoSU+p35+z/O4JL0hl6NuuTImz6EXfMg
         +hQz1apGTZevKGxIf8KSs3d+CY2xxoKTRNFsZXkWbzAE4NBSNKnnWuW9C1qqW+O2LnfG
         INRw==
X-Gm-Message-State: AAQBX9f12dvW/QbHMp8phZ+khSh/e++EY3+bfF758yV+uL+0LhBaOwUF
        1DnB1dM3EojJiEeGzBiqEgHGMA==
X-Google-Smtp-Source: AKy350Z63ysXJoqKJpB8+YQ5aWuV3WL23nvBAF0x7DJEpZqwC1lwwLrpwPzEy54KNMXvONssKjh52Q==
X-Received: by 2002:a17:90b:3c49:b0:23d:19c6:84b7 with SMTP id pm9-20020a17090b3c4900b0023d19c684b7mr23435439pjb.16.1680147849708;
        Wed, 29 Mar 2023 20:44:09 -0700 (PDT)
Received: from [10.254.134.232] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id i19-20020a17090adc1300b0023a8d3a0a6fsm2137129pjv.44.2023.03.29.20.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 20:44:08 -0700 (PDT)
Message-ID: <1a858cce-4d87-5e0a-9274-52cffde7dea6@bytedance.com>
Date:   Thu, 30 Mar 2023 11:44:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [External] Re: [PATCH] blk-throttle: Fix io statistics for cgroup
 v1
To:     Tejun Heo <tj@kernel.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230328142309.73413-1-hanjinke.666@bytedance.com>
 <ZCSJaBO8i5jQFC10@slm.duckdns.org>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <ZCSJaBO8i5jQFC10@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/3/30 上午2:54, Tejun Heo 写道:
> On Tue, Mar 28, 2023 at 10:23:09PM +0800, Jinke Han wrote:
>> From: Jinke Han <hanjinke.666@bytedance.com>
>>
>> Now the io statistics of cgroup v1 are no longer accurate. Although
>> in the long run it's best that rstat is a good implementation of
>> cgroup v1 io statistics. But before that, we'd better fix this issue.
> 
> Can you please expand on how the stats are wrong on v1 and how the patch
> fixes it?
> 
> Thanks.
> 
Now blkio.throttle.io_serviced and blkio.throttle.io_serviced become the 
only stable io stats interface of cgroup v1, and these statistics are 
done in the blk-throttle code. But the current code only counts the bios 
that are actually throttled. When the user does not add the throttle 
limit, the io stats for cgroup v1 has nothing. I fix it according to the 
statistical method of v2, and made it count all ios accurately.

Thanks.
