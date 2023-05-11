Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D6F6FFCBB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239214AbjEKWiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239491AbjEKWiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:38:04 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B3459C6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:38:03 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3330afe3d2fso586915ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683844682; x=1686436682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eb3sWwf5IKoZQzOvkPaaI1IVQ2HjKkCnRKRFnGOH6+c=;
        b=YB4CXa+7IiugZFWW89TQYuVh4HnN1R5IuqF1PWtOFnF45ocw8Zs5UZ19l2DrlhDrL+
         T91s7cNeQp8tLalUmv3BhabCypP9bH6PNCWWysJtJxUfK51iS+unG76XmPRzg+WR9sQw
         +tTzIYC62rYbOgdKq1mzzYyCN9NntV0GOt2BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683844682; x=1686436682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eb3sWwf5IKoZQzOvkPaaI1IVQ2HjKkCnRKRFnGOH6+c=;
        b=P/RBP+j6mhbLBqSWIHwG8mbzGXlgvURtDYVShnwotfMWwFDdnruScQ1dLjhei/8o7e
         /RpKw4rGQD0INdBv1pZjn7KjpFczOhnp0mq8NHEF790ZxW9Q5d2uUXRg6MGbRxp6Ii8j
         w5oF4XWCOCmXsumGhLbrsrqMniJ917D34G9HzgRH9s1RPjzm/g2c3+UQpjOQFJUSVr/k
         Uzgt+pyeShbwlN084nsNWw/+O3JBD3in4QZ8iDG+BjkxdqcJgoexxLBG668rQVaTur1E
         dj2iI6NO7WXoerfPAC1f0uk2foK1fkuDQL4GM9giitCWBC3MbgqEh8sSto35NOsrle6q
         TWvg==
X-Gm-Message-State: AC+VfDwa5i6bkWmNRNwfxJFohj8cpMQtTrW0cPrTHKCrVxae9X4vJ178
        LCov45oi3Eys+hy61aNoYOaBlXzcCmXYHZANlVeU+A==
X-Google-Smtp-Source: ACHHUZ5aB1JvuSw560zhv65bAiwvIZNHMbaJ3VG5IwoL/nVaGBX1hJ51wet8Wz05aOV+TMIKI+1jpET5bN3nE0PPhMc=
X-Received: by 2002:a05:6e02:1ba6:b0:331:4d3c:db55 with SMTP id
 n6-20020a056e021ba600b003314d3cdb55mr122778ili.4.1683844682395; Thu, 11 May
 2023 15:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230511150539.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
 <20230511150539.1.Iabe67a827e206496efec6beb5616d5a3b99c1e65@changeid>
In-Reply-To: <20230511150539.1.Iabe67a827e206496efec6beb5616d5a3b99c1e65@changeid>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 11 May 2023 15:37:50 -0700
Message-ID: <CAODwPW8TqhArafCK3RvBdxyiav3WL=0MU6x=QyBOFP-h8bQrWw@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: interrupt-controller: arm,gic-v3: Add
 quirk for Mediatek SoCs w/ broken FW
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wenst@chromium.org, Eddie Huang <eddie.huang@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Tinghan Shen <tinghan.shen@mediatek.com>, jwerner@chromium.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        yidilin@chromium.org, Seiya Wang <seiya.wang@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Julius Werner <jwerner@chromium.org>
