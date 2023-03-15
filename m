Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332EC6BB7A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjCOPZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjCOPZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:25:41 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEFFEC47
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:25:40 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id r4so10555656ila.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678893940;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=311tmwoPi+X9O5T0jkqGhTRpiGHy+F0ctJn+X1ijaso=;
        b=qYE0Yh+Dr6g5FhU3UDIDpBZiS8bSqullsfODEjWgs48s22YaiRWZjhi72NvARPqxA6
         Mts/ktND9T2CdEZcKS7/GIQvhMpcqWf/XUTxXzqf4ArZpijmzmcLT3Vwaqd7Iqoa6BlH
         ExzgK2RISR/MkDPFNYNKxg0LZtJ27kwk4q7JdhPLwuYLyU9/Gi2ixKzw7PYz4iFVsUaO
         3qXmPreckFEdOvvPf1bFULR69krUdEAAVLZkD6q5l1iM5GZLkxHQRS0VpJBvYT34Kngg
         13HVI6kosHszl3H84XHVeNYdVbgew4iSTjXRIelK6y/iKxWhM4v1ajISD46TzaV9VPcv
         vDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678893940;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=311tmwoPi+X9O5T0jkqGhTRpiGHy+F0ctJn+X1ijaso=;
        b=Nm1pfz9yVuqVi4wInyuXPRn+uYMS1LAvyqxjerA5q+8Am+7omV26kF2nn6E7JLt2GU
         a6XXY/9RQ/tLi2spmdVXxSMPDSkqLswtHZC6Wt5yArpsBTVQTYT9kjV0xOJllmcoIALN
         xQogSHaiAvGdmFNvw5iFTOT9zwUPvYPf10uXA81ejCPrd073Njyh9qsy8Vgz38lyD52R
         39Sa7QadZaEYmnEioCJHyolserarY8CuL0dphVjiP/uzWmSGcSwOXwKaTirGUr8lZlLN
         ZnECqnaDmw+mJK5tZs9XcXHbKGgga7CdDx21mzxaMHBL4duGj8NfK2hBfruX+vvJnSTX
         8DeA==
X-Gm-Message-State: AO0yUKULC74ToqMqy4Eobm49JqcRydfT66aKAyU6YuHCoE/TfaMHg/ax
        svtjZbiROPchxwKPTC0QihVOXA==
X-Google-Smtp-Source: AK7set+GXeS45AV6ZCOSt9EJghEpaRhu4keAdlUsc5MciV2dt1MDmCOkfh6V8QLE789iJhm5iwmeYQ==
X-Received: by 2002:a92:d704:0:b0:317:943c:2280 with SMTP id m4-20020a92d704000000b00317943c2280mr10003193iln.0.1678893940152;
        Wed, 15 Mar 2023 08:25:40 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h11-20020a02b60b000000b003e80d0843e4sm1713415jam.78.2023.03.15.08.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 08:25:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        guz.fnst@cn.fujitsu.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230223091226.1135678-1-yukuai1@huaweicloud.com>
References: <20230223091226.1135678-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next RFC] block: count 'ios' and 'sectors' when io is
 done for bio-based device
Message-Id: <167889393912.42717.4228399799157411797.b4-ty@kernel.dk>
Date:   Wed, 15 Mar 2023 09:25:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Feb 2023 17:12:26 +0800, Yu Kuai wrote:
> While using iostat for raid, I observed very strange 'await'
> occasionally, and turns out it's due to that 'ios' and 'sectors' is
> counted in bdev_start_io_acct(), while 'nsecs' is counted in
> bdev_end_io_acct(). I'm not sure why they are ccounted like that
> but I think this behaviour is obviously wrong because user will get
> wrong disk stats.
> 
> [...]

Applied, thanks!

[1/1] block: count 'ios' and 'sectors' when io is done for bio-based device
      commit: 5f27571382ca42daa3e3d40d1b252bf18c2b61d2

Best regards,
-- 
Jens Axboe



