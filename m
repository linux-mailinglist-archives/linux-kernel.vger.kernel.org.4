Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B19B67F157
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjA0WpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjA0WpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:45:17 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFCA4A1F2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:45:17 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w6-20020a17090ac98600b0022c58cc7a18so1602015pjt.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wXhf32dQp7HTWwdehDrHWyNx8yhhU2eOdzrxP6+BGI=;
        b=GimRNURUFjc43aW2O7LkCumVac07xtD0EtgWJv8AuKxOL8gq0F5cbuLQbbMRCtZu6/
         AVaHCmcguM92uDorzrTs7NL11hT3i1Ji5n6GjG3vc92S5mQBYyuz7Q1st9F4zYPOQznJ
         jxM/DI9Bxfy6v07B3eexP9ojKJq/5Ih1BB9K8uj3HwQwV4LYHejyqelk7ltFd58Cj7p0
         brOaVDfVzYA4FLqVYrcHDfUL7FKZLLUwgJmfkG/qEkiS14ov2jfPpUNiYOcxA4yaR/H5
         4WD3mW/elbmkzKdU8lEbKEba5KQLsn2J3lQjDDcw9E3smdMcfdwlmB/i0guNnY9OFDBZ
         /uSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wXhf32dQp7HTWwdehDrHWyNx8yhhU2eOdzrxP6+BGI=;
        b=JfUr+dlmZZUpsh76MAvbPxJv51v6hnVFdfgtv35IyCNPUIAZ8FWAosyIXltaDuWMkx
         GTPaWf5Fig0JH9JoBc+x/kdJHvJHRDSQqdlzpvkdLf5nF71So1R4PJmlW/E41u1Ev9D/
         MikqS4Nj+h5H362UgJ/kfPH53Pp+fzXfX7QyvWSn/ecyQJG6GoQvzOn3ioBhLqtKixBo
         CcWLVyIM9eotcDuP6UhpHUklyUcDcYl9j/6SdlX/gnyzMQZSzLhvCSu+9Sm7TH4ES39h
         3+LZ5AbkIZEY7cmdzE5E6d1tx9X0SGpdgMbLNZu800S5teUDULSFlarGv7v6ebhj7CE4
         FHmQ==
X-Gm-Message-State: AO0yUKUrEYl1+5MqnfWZNcqB5BH3D8f4Ime9lsK43KaYm1+9X8F6aKNQ
        i/VIcvc2p7AqYJHlQNkWVjm8ug==
X-Google-Smtp-Source: AK7set/urEU+vaRFtR4rBlynkEVi5f4STjzUbdQyrZbnvT7Ewn/tNuPq9vLB2Vx7dTjOwerq1lgG1A==
X-Received: by 2002:a17:902:d4d1:b0:196:1f80:105a with SMTP id o17-20020a170902d4d100b001961f80105amr3123040plg.5.1674859516359;
        Fri, 27 Jan 2023 14:45:16 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001949ae8c275sm3347677plh.141.2023.01.27.14.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 14:45:15 -0800 (PST)
Message-ID: <6d3f76ae-9f86-a96e-d540-cfd45475e288@kernel.dk>
Date:   Fri, 27 Jan 2023 15:45:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 1/2] io_uring,audit: audit IORING_OP_FADVISE but not
 IORING_OP_MADVISE
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Stefan Roesch <shr@fb.com>,
        Christian Brauner <brauner@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <cover.1674682056.git.rgb@redhat.com>
 <68eb0c2dd50bca1af91203669f7f1f8312331f38.1674682056.git.rgb@redhat.com>
 <CAHC9VhSZNGs+SQU7WCD+ObMcwv-=1ZkBts8oHn40qWsQ=n0pXA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHC9VhSZNGs+SQU7WCD+ObMcwv-=1ZkBts8oHn40qWsQ=n0pXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/23 3:35?PM, Paul Moore wrote:
> On Fri, Jan 27, 2023 at 12:24 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>>
>> Since FADVISE can truncate files and MADVISE operates on memory, reverse
>> the audit_skip tags.
>>
>> Fixes: 5bd2182d58e9 ("audit,io_uring,io-wq: add some basic audit support to io_uring")
>> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> ---
>>  io_uring/opdef.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/io_uring/opdef.c b/io_uring/opdef.c
>> index 3aa0d65c50e3..a2bf53b4a38a 100644
>> --- a/io_uring/opdef.c
>> +++ b/io_uring/opdef.c
>> @@ -306,12 +306,12 @@ const struct io_op_def io_op_defs[] = {
>>         },
>>         [IORING_OP_FADVISE] = {
>>                 .needs_file             = 1,
>> -               .audit_skip             = 1,
>>                 .name                   = "FADVISE",
>>                 .prep                   = io_fadvise_prep,
>>                 .issue                  = io_fadvise,
>>         },
> 
> I've never used posix_fadvise() or the associated fadvise64*()
> syscalls, but from quickly reading the manpages and the
> generic_fadvise() function in the kernel I'm missing where the fadvise
> family of functions could be used to truncate a file, can you show me
> where this happens?  The closest I can see is the manipulation of the
> page cache, but that shouldn't actually modify the file ... right?

Yeah, honestly not sure where that came from. Maybe it's being mixed up
with fallocate? All fadvise (or madvise, for that matter) does is
provide hints on the caching or access pattern. On second thought, both
of these should be able to set audit_skip as far as I can tell.

-- 
Jens Axboe

