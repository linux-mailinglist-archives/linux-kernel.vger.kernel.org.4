Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE4A74E2B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 02:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjGKAoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 20:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGKAoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:44:00 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AF1A0;
        Mon, 10 Jul 2023 17:43:59 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-38c35975545so4506284b6e.1;
        Mon, 10 Jul 2023 17:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689036239; x=1691628239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5TM0Cis1Qufjd62wVO+HDL2QcLqTjdEotIvfRAk7EOY=;
        b=qCfSKbe86VbayNbsBWd/76htT4nCaLrMWfXVlmBRsO3CXZr1FoqyIvJO80tnIw5ZRD
         bLKt/Cn8KudhNXrULJOZi/2XYB4PrEyIomwf4MeFw0BZqz58iuWB1sXEZDgm8od0588D
         ZNnPBZLbHhO2Z3QJ+eXezQNTr79/wnFY8gzAj3/sa/fCG/fP3r3I/Zg/C2pCz+8ebrJC
         P5cqh8+ayAPgcfZAhV/jqn189LP0As6p3aW+r7PwKoo8CkXIJc/JZ2WITnvdHDaBQPpN
         dhJxOC7dU01CB9RlWFLbuBFmz7+dFaXiXGXflLQ2o1aFX5uX1sYW6iDlpLv1zwSKt5fW
         eRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689036239; x=1691628239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TM0Cis1Qufjd62wVO+HDL2QcLqTjdEotIvfRAk7EOY=;
        b=UEwtif0B8KSXIdqQ3uu6yZVBWTvj4ZSTFjZYOhqJVajYmygg83h44D6bsjT1oAJiN7
         aXekx1r9bIbssgTPKe81Did3dbJepIfan82da+Z76CelBkUPnWByaBfUPsVrd8V0Arrv
         cEeat4vccjHbcH7d6YXGdMTmpJxG9+HWYUfg/bFSwLfZr0QdG8EgIy+BUpxJZP9oaiTL
         mFMYjLWL3HhfgZ1vCatMd+52r6zqXs38N3bp+uM1JEubZ/P8bcGK5TUfJqzEYA26xhJt
         Eg9XAHse7ogIoLzkn55F0Un06NMp4ni6hb8x2oyjgby04alwTt/zedqS5LeUlkGCdpJB
         f4og==
X-Gm-Message-State: ABy/qLYcMi8JLsfdOVOrH+b7CjKP8EC/F2Jz2JX73DM8czOaNhX9jN8r
        TzckUWSKt4V5lgLdzLE+0S0=
X-Google-Smtp-Source: APBJJlHB+BdQj+gdOWxvyiwMjnGWegcxaMhTBohYeCW0b/OaFeGVe77Cn/BFrGzzslOtZQ1bjL9jzg==
X-Received: by 2002:a05:6808:1493:b0:3a4:182e:6058 with SMTP id e19-20020a056808149300b003a4182e6058mr816671oiw.2.1689036238908;
        Mon, 10 Jul 2023 17:43:58 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:96bf:7e77:39eb:7a23])
        by smtp.gmail.com with ESMTPSA id ey23-20020a056a0038d700b00682a8e600f0sm392403pfb.35.2023.07.10.17.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 17:43:58 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:43:56 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] Input: bcm-keypad - Convert to
 devm_platform_ioremap_resource()
Message-ID: <ZKylzB7KZMlwNZaR@google.com>
References: <20230705052346.39337-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705052346.39337-1-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 01:23:37PM +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

I applied the lot with the exception of patch #9 which is not needed,
with minor edits in patches #8 and #10.

Thanks.

-- 
Dmitry
