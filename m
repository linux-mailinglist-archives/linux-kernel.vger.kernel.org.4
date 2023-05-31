Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F115E71729C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjEaAg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjEaAgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:36:24 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E28D198
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:35:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d3bc502ddso5987804b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685493314; x=1688085314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23xeKFVPUFVZGWBGcJOCGL5XHLy6P13RAX8/V5+vCsQ=;
        b=Zzi32WniBs2qsNeUcZpuHj0aOjghw34hMXI5mJNDxSCxlmScNB1KaOhHw7iIfDXPo1
         V+jdLZdCOzmJooq6ReyEDuonbANQua+JQIP1YJFlqoP/IHorvyr0YYOmGECTz+XEU8W8
         EydPfFdpfxo3g/a7Wxf7xDZ9RWRkyg/K5RKZo4V7QaQby6Waw3flS1exibwyhrX+ksir
         hWZ9uAXvX2LXvo69boWk2o4ueD1iGQMhmiX78hfG1iqKuix9f1sdkWs1vDPLIUCKwnGh
         bTs0aZMZ+YDXt2swYoP3zYIG2IbZ+YtekjrreHr36dU+IgCCSMbYSVQQKKEUMwy5FaLA
         lgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685493314; x=1688085314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23xeKFVPUFVZGWBGcJOCGL5XHLy6P13RAX8/V5+vCsQ=;
        b=Am/c1vJz1d2VPxckfCgJRN466xJ4FfJXZe7UJBugTijODaJL6ggkndMrzuOtN8k0qy
         4hWLmzie7I30mF6ayjrSqN2HYHNT00sWIQBUbb8pJYgyp49zw6/HT3d9hTSLMpC1DX9/
         SFUITgUNC266/lTV6HI/SRWKzNdEHGLgO30E+40SQM+ph+DyBWSryRyHEnnFA3bFPBDd
         x6OjGSxHSCYzZVCIAANDURQchtDXvQiooGGLw8EkRvtSsTCtmiTPs0MZ/jcfIAq88Bb4
         +Ktf7pDlxoPA8ybQ/Q/Kop2uEb6eMUEXq4M1eKy0/yUxX4zJXvUcOJ+f1XyMSLoUZHAF
         ST8g==
X-Gm-Message-State: AC+VfDw2IR5rnuwXOQUoEUMvO0/WP6ji3WKtanHZruQueAe4A9oSw22E
        NSyKutgt6LTYUbiSQgc1fHvY5Q==
X-Google-Smtp-Source: ACHHUZ6FcM3ztXr+/sYU8OWmAw8FbDZaKJuUZBXSFWUbBlS4izbiuRG7Pr592dIDgc8xqRBmJvB8qw==
X-Received: by 2002:a05:6a20:1583:b0:10d:b160:3d5f with SMTP id h3-20020a056a20158300b0010db1603d5fmr5045134pzj.38.1685493314237;
        Tue, 30 May 2023 17:35:14 -0700 (PDT)
Received: from [172.17.0.2] (c-67-170-131-147.hsd1.wa.comcast.net. [67.170.131.147])
        by smtp.gmail.com with ESMTPSA id j12-20020a62b60c000000b0064cb0845c77sm2151340pff.122.2023.05.30.17.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:35:13 -0700 (PDT)
From:   Bobby Eshleman <bobby.eshleman@bytedance.com>
Date:   Wed, 31 May 2023 00:35:09 +0000
Subject: [PATCH RFC net-next v3 5/8] virtio/vsock: add VIRTIO_VSOCK_F_DGRAM
 feature bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v3-5-c2414413ef6a@bytedance.com>
References: <20230413-b4-vsock-dgram-v3-0-c2414413ef6a@bytedance.com>
In-Reply-To: <20230413-b4-vsock-dgram-v3-0-c2414413ef6a@bytedance.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>
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

This commit adds a feature bit for virtio vsock to support datagrams.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 include/uapi/linux/virtio_vsock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
index 64738838bee5..772487c66f9d 100644
--- a/include/uapi/linux/virtio_vsock.h
+++ b/include/uapi/linux/virtio_vsock.h
@@ -40,6 +40,7 @@
 
 /* The feature bitmap for virtio vsock */
 #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
+#define VIRTIO_VSOCK_F_DGRAM		3	/* Host support dgram vsock */
 
 struct virtio_vsock_config {
 	__le64 guest_cid;

-- 
2.30.2

