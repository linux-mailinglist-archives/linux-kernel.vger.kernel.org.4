Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AFE62D87A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbiKQKxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239029AbiKQKwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:52:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327231CB2D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668682232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GBLjqaxD9YXzB2a0G4EC2tB+BR3145svbgGOvljSx80=;
        b=SWvNdvXQI8YP3WMiFeud4czCuQoGsjLb2LoJMdY6NJBmQgbaCzS7ptxB1VAZx/pVnZMJDP
        SkfoimLgxYnP4cGqcpfPIZ+B3xygopW+EnHFgPv2mHhXUfwSi+SQsai8oqfhvllYuPLbej
        yw2AIuJH1APQ+K1JRlhPN5xRApNP3Hw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-YmCRkJ4JOfuwYjWAkf9tmg-1; Thu, 17 Nov 2022 05:50:26 -0500
X-MC-Unique: YmCRkJ4JOfuwYjWAkf9tmg-1
Received: by mail-qk1-f197.google.com with SMTP id bk30-20020a05620a1a1e00b006fb2378c857so1629799qkb.18
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBLjqaxD9YXzB2a0G4EC2tB+BR3145svbgGOvljSx80=;
        b=t5N9fgILrL0sLDkewGLbVxMFSjb37YlZxLDZ4b84xtdvNy8pXxqTPDGJDli9DYZkbE
         w/VjldKdkAc4/I+WEoS3WkP0e5aCe9WQBWjVyC//fIZ+8DEOhYJKlA1WYG3BuSLIagq5
         CPQsR8IW6G/+LGrn1Zbrb3bIf6jIc1Q1vj6EHOIheH8QJI5hy8+8WGw4uMWKoxA79XBb
         r5l2uTaprstz136gzLZP+9fyhrEj9HmLiFCyliDpfuKl56uP3wHyf0+r/0GH6D9iWlRD
         WwT20YTeHFnzELd+mYldcuTmQwerHH/qehM2iSlgQ5KGHXiTTMof5BoyYowCPzGehFk3
         WMbg==
X-Gm-Message-State: ANoB5pmfQ3jC8wOjIHU6I1dLcZFA4NMRepRnx1qxdfrljCI6giSI3J2x
        A32G2lO76TgV1+yKBC20pxCJPeJfL69bPxEL1Gtto0siLaRQPViWFOihJCg6Exq+JnGyVitEsM0
        sX2nvUhNpA7E2zNWYJ2DWPvHq
X-Received: by 2002:ac8:4e47:0:b0:3a5:c306:324 with SMTP id e7-20020ac84e47000000b003a5c3060324mr1650352qtw.116.1668682226062;
        Thu, 17 Nov 2022 02:50:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Hp8ueJ2odeFAiwGWASh3iAkry+xnk/8bkoOGXMK9ipdlHU+fDlbp30euEWUKaHFyqpmn8jQ==
X-Received: by 2002:ac8:4e47:0:b0:3a5:c306:324 with SMTP id e7-20020ac84e47000000b003a5c3060324mr1650342qtw.116.1668682225822;
        Thu, 17 Nov 2022 02:50:25 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id i15-20020a05620a248f00b006fa9d101775sm236022qkn.33.2022.11.17.02.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 02:50:25 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 0/2] qcom: add basic interconnect support to UFS
Date:   Thu, 17 Nov 2022 05:49:55 -0500
Message-Id: <20221117104957.254648-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds very basic support for the interconnect framework
to the Qualcomm portion of the UFS framework since the firmware on
these platforms expects the interconnect votes to be present. The
maximum throughput is requested to match what's already done in a few
other drivers.

Here's the relevant entries from the interconnect_summary file in
debugfs that shows the two ICC paths are setup for the first UFS
host controller on the SA8540p automotive board (sc8280xp).

 node                                  tag          avg         peak
--------------------------------------------------------------------
xm_ufs_mem                                            0   4294967295
  1d84000.ufs                            0            0   4294967295
qns_a1noc_snoc                                        0   4294967295
  1d84000.ufs                            0            0   4294967295
qnm_gemnoc_cnoc                                     115   4294967295
  1d84000.ufs                            0            0   4294967295
  a6f8800.usb                            0            0        40000
  884000.serial                          0          115          115
qhs_ufs_mem_cfg                                       0   4294967295
  1d84000.ufs                            0            0   4294967295
chm_apps                                            115   4294967295
  1d84000.ufs                            0            0   4294967295
  a6f8800.usb                            0            0        40000
  884000.serial                          0          115          115
qnm_snoc_sf                                     1000000   4294967295
  1d84000.ufs                            0            0   4294967295
  a6f8800.usb                            0      1000000      2500000
qns_gem_noc_cnoc                                    115   4294967295
  1d84000.ufs                            0            0   4294967295
  a6f8800.usb                            0            0        40000
  884000.serial                          0          115          115
qns_llcc                                        1000000   4294967295
  1d84000.ufs                            0            0   4294967295
  a6f8800.usb                            0      1000000      2500000
llcc_mc                                         1000000   4294967295
  1d84000.ufs                            0            0   4294967295
  a6f8800.usb                            0      1000000      2500000
ebi                                             1000000   4294967295
  1d84000.ufs                            0            0   4294967295
  a6f8800.usb                            0      1000000      2500000
qnm_aggre1_noc                                        0   4294967295
  1d84000.ufs                            0            0   4294967295
qns_gemnoc_sf                                   1000000   4294967295
  1d84000.ufs                            0            0   4294967295
  a6f8800.usb                            0      1000000      2500000


Brian Masney (2):
  scsi: ufs: ufs-qcom: add basic interconnect support
  arm64: dts: qcom: sc8280xp: add interconnect properties to ufs nodes

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi |  8 ++++++++
 drivers/ufs/host/ufs-qcom.c            | 25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

-- 
2.38.1

