Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B302C5F37BC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJCV21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJCV1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:27:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DDD564FC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:18:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f3-20020a056902038300b00696588a0e87so11313993ybs.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=PKzXfD2XClUKd7bCuauqP5OpzLf49pwEY4tUB0Nih7E=;
        b=IwacVuVpsg/LX6Wywy9/n/z66xUUBUzej5c9EMDGiMHMKXNCA/bp07rAjDHJU6QYdp
         R21K10s/yZmQHJZWSMTAJ6wlNldZn+VPTSKV8cwFPy5UDibkqPwtjvP538d+EAI0A3Y3
         diJNhGdNIeaFg62APXflkjkoGOf/++E8wq95RHxINg+q3t3mS+zCul/zxSs3cWl67sbn
         HHvsPBq6oqjfhf/vVg7O0g2DIIRabl2M+mWq9b4KTQJgWrZ+IBo3YmpRm/PfxJXdMHCt
         HJw80wA5J4GX2q2sQKG8eIqXdgrHtJfhzK4YZBZkaUKi+H/ZfYPdIDb52Ur+ZmBV2s+d
         XhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=PKzXfD2XClUKd7bCuauqP5OpzLf49pwEY4tUB0Nih7E=;
        b=yxu6DTPDSmnGFx0f9Aip9UVMyvMgMxsZzw6iGTcvfEFoHpcerIa8+xnrJnLkJj3HkO
         NnevVvj8btXPoV19bT7pCG8jGyPwlu4auGY1WxaLGjjaLXDP/LGseHkNuyM3NN8Bpl9E
         yLLugngiy6JFM/1ZXQHHefIzc7HEuyLkCGD2caA+Nx3yvTYLDRjTz4qwAs0EoSn1V2Zr
         1Makxp0YGzhXSerhh+g9BOhI7bDrfRT7v4n283r4GA2mZw0tzsyP8fBQI0AX3GZ6CE/q
         6oIXWSLfWh5/Rn9zVKK8SmR8LofgX+ClRHt6xwpc+cyF6RaUYxa9eCjByyyE7RX5nbcP
         p45g==
X-Gm-Message-State: ACrzQf2iUumHxpd+2jJlMmxaIn61b9azWv1h/+ec7bdyyZDL7cSnbcxq
        nW42SL9MZHFWqfp7fSHiYhAACBTgRqNO0Q==
X-Google-Smtp-Source: AMsMyM5rj0ne9B+JWRRcdzkLHFdLNm3OEQkjS9DsFOQnOPI9EtBC2zEUlor4syMlsL3rYAFUwrTSOuxIRBPgpw==
X-Received: from neelnatu0.svl.corp.google.com ([2620:15c:2cd:202:42db:aed0:e4a3:4647])
 (user=neelnatu job=sendgmr) by 2002:a25:846:0:b0:6a8:c5de:3e37 with SMTP id
 67-20020a250846000000b006a8c5de3e37mr21952034ybi.412.1664831918850; Mon, 03
 Oct 2022 14:18:38 -0700 (PDT)
Date:   Mon,  3 Oct 2022 14:18:08 -0700
In-Reply-To: <20220824191223.1248-2-chang.seok.bae@intel.com>
Mime-Version: 1.0
References: <20220824191223.1248-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003211808.1291343-1-neelnatu@google.com>
Subject: Re: [PATCH 1/3] x86/fpu: Configure init_fpstate attributes orderly
From:   Neel Natu <neelnatu@google.com>
To:     chang.seok.bae@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, neelnatu@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: neelnatu@google.com
