Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D734B66099D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbjAFWjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjAFWjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:39:40 -0500
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C432B872AA;
        Fri,  6 Jan 2023 14:39:39 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id c4so3209382plc.5;
        Fri, 06 Jan 2023 14:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wllrSnnUtP2lGzMZ5NnJc5XBcURZs1X9kJ2O+mtnmI=;
        b=bP9/h1lh06CmWlRZUK8dr9BunGFdM6/10n32IKDuXsqbBn4je5Y+4n8c+jCTzfoGpi
         +4Jd1gSW3WdZKZ5zKE+LB+sYoatt1aOJ1ds/31zhZYyP0m/5AOUnxBc7ymXJ0XArZQ5O
         QB/5mayIRR2VeVy1FhwzcNUzwQG6jy8WYIWIr3Q7vHnYEuPOzKECFVvlFuptXNALx34f
         L9WSPlHCblsmEd6IKZ07xvYX3+IZDIjcO90XucQ+HFoFmPOvOiboGTnMNJQzkcBtT9Zw
         IgGoHDAs9DVvbd8NGbq/yYUAC+RV5sMauC5FUGKmwv/1LMRm7CuxsqRXQAfZRbySUuum
         DNaw==
X-Gm-Message-State: AFqh2kovZWBNfWwHhcDEeU4EqY+NJ2C7Shr1dcIK6hJS4uOlDcfLgyQu
        C0hPsG546WTazsMgWZmbOE0=
X-Google-Smtp-Source: AMrXdXuMcgHd17Og+hOTPa7FzU9kTPhBKiF/SMXTbwL3fZXTnntDEJhZH/XSa/hH2zGddJvohv5qng==
X-Received: by 2002:a17:902:f7c2:b0:192:6cc9:922 with SMTP id h2-20020a170902f7c200b001926cc90922mr43243418plw.59.1673044779250;
        Fri, 06 Jan 2023 14:39:39 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:23c3:f25b:a19d:c75a? ([2620:15c:211:201:23c3:f25b:a19d:c75a])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b00174c0dd29f0sm1410874plg.144.2023.01.06.14.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 14:39:38 -0800 (PST)
Message-ID: <1484d284-e55e-4e3d-b4fc-5a685002c656@acm.org>
Date:   Fri, 6 Jan 2023 14:39:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/7] nvmet: introduce bdev_zone_no helper
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, snitzer@kernel.org, dm-devel@redhat.com,
        damien.lemoal@opensource.wdc.com, linux-nvme@lists.infradead.org,
        hch@lst.de, linux-block@vger.kernel.org, gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083320eucas1p1d23de4ad21d0a7aecb74c549ebc7757c@eucas1p1.samsung.com>
 <20230106083317.93938-4-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230106083317.93938-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/23 00:33, Pankaj Raghav wrote:
> A generic bdev_zone_no() helper is added to calculate zone number for a
> given sector in a block device. This helper internally uses disk_zone_no()
> to find the zone number.
> 
> Use the helper bdev_zone_no() to calculate nr of zones. This let's us
> make modifications to the math if needed in one place.

Please use the imperative mood in patch descriptions (... is added -> 
add ...).

let's -> lets

If these two issues are addressed, please add:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
