Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE669681452
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbjA3PMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbjA3PMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:12:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA13139CE5;
        Mon, 30 Jan 2023 07:12:23 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UDc0SU008128;
        Mon, 30 Jan 2023 15:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rT3u7gjmfmsV97BmPZPdZCMxSGiWO9GwfzEkSjadot8=;
 b=U1bJZ/2zm3jR9mCxdW7ZUDLK7Kvh2oOhgQ8neD8aTdEa7uAcK9oe9pNYkCKXEmqc3vq9
 +WJgTcyL18MUC36SCowKTRwVeilB+X+LYLH9J9IJCrOnou0o3H860JShx+4xoUrabZdN
 5aEpA9Ajzu62QUYm5cIvqpNrtdRSztO/iJ7D8LpEEcFwFby1M67Ao4wQfJNgbvv/Hynr
 tsYysAgumwyqPzpYVWSMY76NqU8UXK9/fB9w1JJy8eQEuXB0mW4ny5ZJ83UHQhe5s1+l
 aQZwSvxze9h9MB9FLhIStMPU7rd1g1c/S0pkmzVEJJ061hqo3wIY74VMTP2/oPCdpwFu Og== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncvvu3sy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 15:12:20 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UFCJ4b019745
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 15:12:19 GMT
Received: from vpolimer-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 07:12:14 -0800
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>
CC:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <robdclark@gmail.com>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <quic_kalyant@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_khsieh@quicinc.com>, <quic_vproddut@quicinc.com>,
        <quic_bjorande@quicinc.com>, <quic_abhinavk@quicinc.com>,
        <quic_sbillaka@quicinc.com>
Subject: [PATCH v12 05/14] drm: add helper functions to retrieve old and new crtc
Date:   Mon, 30 Jan 2023 20:41:25 +0530
Message-ID: <1675091494-13988-6-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1675091494-13988-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1675091494-13988-1-git-send-email-quic_vpolimer@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: itLKK9yyeIHTCcGdNxErBfer1TLmeXRC
X-Proofpoint-ORIG-GUID: itLKK9yyeIHTCcGdNxErBfer1TLmeXRC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_14,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=859 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301300147
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new helper functions, drm_atomic_get_old_crtc_for_encoder
and drm_atomic_get_new_crtc_for_encoder to retrieve the
corresponding crtc for the encoder.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_atomic.c | 60 ++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_atomic.h     |  7 ++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 5457c02..7cc39f6 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -985,6 +985,66 @@ drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_state *state,
 EXPORT_SYMBOL(drm_atomic_get_new_connector_for_encoder);
 
 /**
+ * drm_atomic_get_old_crtc_for_encoder - Get old crtc for an encoder
+ * @state: Atomic state
+ * @encoder: The encoder to fetch the crtc state for
+ *
+ * This function finds and returns the crtc that was connected to @encoder
+ * as specified by the @state.
+ *
+ * Returns: The old crtc connected to @encoder, or NULL if the encoder is
+ * not connected.
+ */
+struct drm_crtc *
+drm_atomic_get_old_crtc_for_encoder(struct drm_atomic_state *state,
+				    struct drm_encoder *encoder)
+{
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
+
+	connector = drm_atomic_get_old_connector_for_encoder(state, encoder);
+	if (!connector)
+		return NULL;
+
+	conn_state = drm_atomic_get_old_connector_state(state, connector);
+	if (!conn_state)
+		return NULL;
+
+	return conn_state->crtc;
+}
+EXPORT_SYMBOL(drm_atomic_get_old_crtc_for_encoder);
+
+/**
+ * drm_atomic_get_new_crtc_for_encoder - Get new crtc for an encoder
+ * @state: Atomic state
+ * @encoder: The encoder to fetch the crtc state for
+ *
+ * This function finds and returns the crtc that will be connected to @encoder
+ * as specified by the @state.
+ *
+ * Returns: The new crtc connected to @encoder, or NULL if the encoder is
+ * not connected.
+ */
+struct drm_crtc *
+drm_atomic_get_new_crtc_for_encoder(struct drm_atomic_state *state,
+				    struct drm_encoder *encoder)
+{
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
+
+	connector = drm_atomic_get_new_connector_for_encoder(state, encoder);
+	if (!connector)
+		return NULL;
+
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	if (!conn_state)
+		return NULL;
+
+	return conn_state->crtc;
+}
+EXPORT_SYMBOL(drm_atomic_get_new_crtc_for_encoder);
+
+/**
  * drm_atomic_get_connector_state - get connector state
  * @state: global atomic state object
  * @connector: connector to get state object for
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 92586ab..9a022ca 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -528,6 +528,13 @@ struct drm_connector *
 drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_state *state,
 					 struct drm_encoder *encoder);
 
+struct drm_crtc *
+drm_atomic_get_old_crtc_for_encoder(struct drm_atomic_state *state,
+					 struct drm_encoder *encoder);
+struct drm_crtc *
+drm_atomic_get_new_crtc_for_encoder(struct drm_atomic_state *state,
+					 struct drm_encoder *encoder);
+
 /**
  * drm_atomic_get_existing_crtc_state - get CRTC state, if it exists
  * @state: global atomic state object
-- 
2.7.4

