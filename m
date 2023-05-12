Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F67700AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241442AbjELOy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241625AbjELOyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:54:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61E010A0A
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:54:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f315712406so325594615e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683903278; x=1686495278;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/c6xQdMNlqD6BX9rAHAsLSjJBDh1LbniTf1OGAulrY=;
        b=U2JR9M3KsiuTLgnyul8FlKynONlWgVFiVIR9EFUtuPYv4x+DUoZEI3pmNxbDCbASva
         c+0KKSPZhLfwTHLjqXbliWEOANLEqAmcL8T8R+HJICchD+HG4OonhZXLOBSFIKAD3SXc
         04DmZBs6n/QMuPSv3V44+n6HLVO3i2PVh7uyxe9UdDnq50xjAj+agCWMGR41NYgw31rl
         MmeCGXLRFmqjEnnH1VHvkmOeHbzGQ6+VNqu6mMQge/xVCOp2uxJbUeRONhckqoXOjugb
         sb5vzECoctwRRvcs6jTisujerrpzoMP7nFfJbe225QyRd9aOAbdfWfaUrod6d4U3iPXc
         9nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683903278; x=1686495278;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/c6xQdMNlqD6BX9rAHAsLSjJBDh1LbniTf1OGAulrY=;
        b=cTGdegFqGQNz0CkhtrcNlj8YSYAXi5dAqOMWk+yrH0OeOR2N+h7wz9hafc/0X5qI+n
         U3UpBgjEQ6EZbmMnE+Fedqitt216rpurNw8I5OM7Mn1ttaHpRjSgeTfrTq7dgT96Opjk
         KDdlf2XfZ6YnP7dVk/x682laZ6Cs4E//eAO9iiiIYaB5AKEvn6G/uMJ7r8cPH8ygvnGX
         gTxdqEYhvOrpBfsr5Q/87RJuhTsL0gqEuF2WqLPY/E3LMQgS4cYjsKSCyFOqRfFDlWvg
         IsA066xk9Pyx4d34o0roZoxp3zIznoOjGUtt9XDK6C/iug+pvskooMqJh0nxxR8QU194
         mhIg==
X-Gm-Message-State: AC+VfDxZEXLw06O4EZV2+vjlbhqvU+vBMp5z0Ka9j6s4s/s86WfLEn5z
        dXzi384Lk44cEo4V/j3GIT1ABg==
X-Google-Smtp-Source: ACHHUZ7STIqlliSH6S01kSMH6qPCsoMbcUPRMKbDI84fu8KRRpED6A+uJUgkCvv/6LOelckEf5mwxg==
X-Received: by 2002:a05:600c:2197:b0:3f4:2158:28a0 with SMTP id e23-20020a05600c219700b003f4215828a0mr12511244wme.12.1683903278554;
        Fri, 12 May 2023 07:54:38 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003f32f013c3csm28953540wmh.6.2023.05.12.07.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 07:54:37 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     linux-arm-msm@vger.kernel.org,
        Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, bkumar@qti.qualcomm.com,
        fastrpc.upstream@qti.qualcomm.com, stable <stable@kernel.org>
In-Reply-To: <1679394100-27119-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1679394100-27119-1-git-send-email-quic_ekangupt@quicinc.com>
Subject: Re: [PATCH v1] misc: fastrpc: Reassign memory ownership only for
 remote heap
Message-Id: <168390327749.185210.3662822283273466169.b4-ty@linaro.org>
Date:   Fri, 12 May 2023 15:54:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Mar 2023 15:51:40 +0530, Ekansh Gupta wrote:
> The userspace map request for remote heap allocates CMA memory.
> The ownership of this memory needs to be reassigned to proper
> owners to allow access from the protection domain running on
> DSP. This reassigning of ownership is not correct if done for
> any other supported flags.
> 
> When any other flag is requested from userspace, fastrpc is
> trying to reassign the ownership of memory and this reassignment
> is getting skipped for remote heap request which is incorrect.
> Add proper flag check to reassign the memory only if remote heap
> is requested.
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: Reassign memory ownership only for remote heap
      commit: 5fad4a6b2d8f05c4823a08465e584f46df798b1f

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

