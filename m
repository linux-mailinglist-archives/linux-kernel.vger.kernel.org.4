Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189D1698439
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjBOTNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBOTN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:13:29 -0500
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60E73AB2;
        Wed, 15 Feb 2023 11:13:28 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id b5so21239707plz.5;
        Wed, 15 Feb 2023 11:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWTRjyxtvc0B3GvrSev36WvGpzJc/fNKHJWJ+vb4bhA=;
        b=49ydPwBjz+WzsbRMnsSrTKtY7rUvpq6KqG/iIxkh1htk20la+6ooPGTsEzWiRt/u3X
         m4fyJnWkhMrISuLQxf2IvgpYwq8oM1g2Dm2Pk5I1KyRhS4d1LmZ0HfufvRQHAJNfyPiZ
         GZJl3YRTYvo979wAlNAnJNA2dqJ025hGWQqY2oLBx91hZoWuAbAW9QNqEqAF15J02TUE
         21HAF3NiSD2Yi3xTmhGE7IDl4qy+TZYeaH+oLFP5cvlnOgjRtL0hSuwtIIJGUWUE/Z1G
         mFX3EF9vKVWY8xkWREgMmLSlMdtC1qxq2HBfed4h0wJLqlme0gZyn/+i77eAKMinBgeY
         1yoQ==
X-Gm-Message-State: AO0yUKWTKJl3l+MNutu6GnVQOEh7NlDI7VpJI/J85mEv4UIVRM7pVqXF
        15h+pgZrHAUZGYykPTxbN3s=
X-Google-Smtp-Source: AK7set+RPel0IwOsNbPzqRd/rBjjcisz97M1b80sFVC+EpObXiag94SVGUKB9QQSQ9jnbThmLDE4ow==
X-Received: by 2002:a17:90b:4a02:b0:233:f354:e7f6 with SMTP id kk2-20020a17090b4a0200b00233f354e7f6mr4027461pjb.46.1676488408130;
        Wed, 15 Feb 2023 11:13:28 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:f2b7:9a62:c95d:fb83? ([2620:15c:211:201:f2b7:9a62:c95d:fb83])
        by smtp.gmail.com with ESMTPSA id ob4-20020a17090b390400b00233790759cesm1808115pjb.47.2023.02.15.11.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 11:13:27 -0800 (PST)
Message-ID: <20feb1ab-5515-66f4-25cc-297511e44556@acm.org>
Date:   Wed, 15 Feb 2023 11:13:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] scsi: ufs: support IO traces for zoned block device
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>
Cc:     Jaegeuk Kim <jaegeuk@google.com>
References: <20230215190448.1687786-1-jaegeuk@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230215190448.1687786-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/23 11:04, Jaegeuk Kim wrote:
> Let's support WRITE_16, READ_16, ZBC_IN, ZBC_OUT.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
