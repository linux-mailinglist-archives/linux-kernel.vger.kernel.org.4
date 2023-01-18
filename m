Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDE767106F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjARByY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjARByW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:54:22 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391D04A21B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:54:21 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so449347wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thVLVROfX6AvPBKTUyk8ux14/6qppawT7dt0nyTi8Lc=;
        b=gfLdwhvtjCP6/74XGTQQJcA7iGaS4m87AHEBSP5sD16YNFRhl9vS4OwpV7jSH+idhH
         srgibYZnk4NkHdvQTDvKfaHBmvrYCg5+yb9Q6PvBmHIeXuq6+DfT4LmwtBTHF/EGdwXl
         C3coOPpKVt+Oxh6I5rBOFA1MzJI93BDRoB/wOgptl9DAqWel2T1Akf2L+y6gUi0qtFex
         NS8+DnE5VyO9TqY8PIefBcJCmZ2SaCcIlm92DPzXUJ6cymW9vPmPTMm+m+uZ/N8kj/Xv
         YHJ7dZ35CItYN65ejGnk+UDmi1vzXgr9DYVUIKpjUO+iMu+Z0PbRfvjPmNTmO1jPngoy
         tJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thVLVROfX6AvPBKTUyk8ux14/6qppawT7dt0nyTi8Lc=;
        b=lCTHZZ/WYC9YTAzWewv5SkA1alY15HSidPQjqJcByCh8xmpNIKU0J1TLXpeSBZt4Vv
         6tA7+BBbBkPtqOB6zQlKFzwW4N69N0nG+1J+DhBOfKDJWq930UwkwsoqJA5NtgS5xHI6
         IE91LHVipHnBHox0kLHHn62j/S+Gp0yeL+nCGIkQm56ozDke7V7dXA8nOTFXQhbyah6+
         rJWYRUhnK3uAq//r6c07RKlbfX9OtaxFmKbEL0mZYkR8OEcaaR5evOEnw/JGR5njttKS
         hnHYP23qyYSrZSJEMc8nend1JLQBL9FpkuZjsjlVFqrEZTmjQxfNGhTkWQtgO36OMW3y
         TYfQ==
X-Gm-Message-State: AFqh2kqoNK0TqrX+IdqVHlrw5vkMOwmBcpOmfLwrtQnwfmY/ONoXm+36
        YlB64pspgNoNENDWldH8yQHSwFHSNwsmk/H1
X-Google-Smtp-Source: AMrXdXv//7iE8nVbevIc5WQF2jxSlhQMI2dNCCYQgusye0d7toEjXRfqJCmv3LQ9+KG9V6qyZyXi6w==
X-Received: by 2002:a05:600c:1d22:b0:3da:f66c:795d with SMTP id l34-20020a05600c1d2200b003daf66c795dmr5261659wms.9.1674006859635;
        Tue, 17 Jan 2023 17:54:19 -0800 (PST)
Received: from solport.. (80.red-83-42-43.dynamicip.rima-tde.net. [83.42.43.80])
        by smtp.gmail.com with ESMTPSA id q12-20020adff50c000000b002be25db0b7bsm2043264wro.10.2023.01.17.17.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 17:54:18 -0800 (PST)
From:   Joan Bruguera <joanbrugueram@gmail.com>
To:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, "Juergen Gross" <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "Jan Beulich" <jbeulich@suse.com>,
        "Roger Pau Monne" <roger.pau@citrix.com>,
        "Kees Cook" <keescook@chromium.org>, mark.rutland@arm.com,
        "Andrew Cooper" <Andrew.Cooper3@citrix.com>,
        =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 0/7] x86: retbleed=stuff fixes
Date:   Wed, 18 Jan 2023 01:54:12 +0000
Message-Id: <20230118015412.273150-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230116142533.905102512@infradead.org>
References: <20230116142533.905102512@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I've been testing those patches on my real system (i5-7200U) for
the last day with no problems so far, waking from s2ram works as well.
I can also no longer see those `sarq $5, %gs:0x1337` with %gs=0 on QEMU.

Regards,
- Joan
