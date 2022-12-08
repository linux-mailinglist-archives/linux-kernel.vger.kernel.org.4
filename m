Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4C56467F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 04:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiLHDkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 22:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLHDkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 22:40:21 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9766460364;
        Wed,  7 Dec 2022 19:40:18 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NSKfn0Kxwz501R0;
        Thu,  8 Dec 2022 11:40:17 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B83e50l084393;
        Thu, 8 Dec 2022 11:40:05 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 8 Dec 2022 11:40:06 +0800 (CST)
Date:   Thu, 8 Dec 2022 11:40:06 +0800 (CST)
X-Zmail-TransId: 2af963915c9664a92d29
X-Mailer: Zmail v1.0
Message-ID: <202212081140062735330@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <mchehab@kernel.org>
Cc:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtZWRpYTogc2lhbm86IENvbnZlcnQgdG8gdXNlIHN5c2ZzX2VtaXRfYXQoKSBBUEk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B83e50l084393
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 63915CA1.000 by FangMail milter!
X-FangMail-Envelope: 1670470817/4NSKfn0Kxwz501R0/63915CA1.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63915CA1.000/4NSKfn0Kxwz501R0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/media/common/siano/smsdvb-debugfs.c | 334 +++++++-------------
 1 file changed, 117 insertions(+), 217 deletions(-)

diff --git a/drivers/media/common/siano/smsdvb-debugfs.c b/drivers/media/common/siano/smsdvb-debugfs.c
index 8916bb644756..e0beefd80d7b 100644
--- a/drivers/media/common/siano/smsdvb-debugfs.c
+++ b/drivers/media/common/siano/smsdvb-debugfs.c
@@ -45,89 +45,48 @@ static void smsdvb_print_dvb_stats(struct smsdvb_debugfs *debug_data,

 	buf = debug_data->stats_data;

-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "is_rf_locked = %d\n", p->is_rf_locked);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "is_demod_locked = %d\n", p->is_demod_locked);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "is_external_lna_on = %d\n", p->is_external_lna_on);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "SNR = %d\n", p->SNR);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "ber = %d\n", p->ber);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "FIB_CRC = %d\n", p->FIB_CRC);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "ts_per = %d\n", p->ts_per);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "MFER = %d\n", p->MFER);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "RSSI = %d\n", p->RSSI);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "in_band_pwr = %d\n", p->in_band_pwr);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "carrier_offset = %d\n", p->carrier_offset);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "modem_state = %d\n", p->modem_state);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "frequency = %d\n", p->frequency);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "bandwidth = %d\n", p->bandwidth);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "transmission_mode = %d\n", p->transmission_mode);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "modem_state = %d\n", p->modem_state);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "guard_interval = %d\n", p->guard_interval);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "code_rate = %d\n", p->code_rate);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "lp_code_rate = %d\n", p->lp_code_rate);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "hierarchy = %d\n", p->hierarchy);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "constellation = %d\n", p->constellation);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "burst_size = %d\n", p->burst_size);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "burst_duration = %d\n", p->burst_duration);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "burst_cycle_time = %d\n", p->burst_cycle_time);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "calc_burst_cycle_time = %d\n",
-		      p->calc_burst_cycle_time);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "num_of_rows = %d\n", p->num_of_rows);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "num_of_padd_cols = %d\n", p->num_of_padd_cols);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "num_of_punct_cols = %d\n", p->num_of_punct_cols);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "error_ts_packets = %d\n", p->error_ts_packets);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "total_ts_packets = %d\n", p->total_ts_packets);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "num_of_valid_mpe_tlbs = %d\n", p->num_of_valid_mpe_tlbs);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "num_of_invalid_mpe_tlbs = %d\n", p->num_of_invalid_mpe_tlbs);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "num_of_corrected_mpe_tlbs = %d\n", p->num_of_corrected_mpe_tlbs);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "ber_error_count = %d\n", p->ber_error_count);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "ber_bit_count = %d\n", p->ber_bit_count);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "sms_to_host_tx_errors = %d\n", p->sms_to_host_tx_errors);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "pre_ber = %d\n", p->pre_ber);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "cell_id = %d\n", p->cell_id);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "dvbh_srv_ind_hp = %d\n", p->dvbh_srv_ind_hp);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "dvbh_srv_ind_lp = %d\n", p->dvbh_srv_ind_lp);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "num_mpe_received = %d\n", p->num_mpe_received);
+	n += sysfs_emit_at(buf, n, "is_rf_locked = %d\n", p->is_rf_locked);
+	n += sysfs_emit_at(buf, n, "is_demod_locked = %d\n", p->is_demod_locked);
+	n += sysfs_emit_at(buf, n, "is_external_lna_on = %d\n", p->is_external_lna_on);
+	n += sysfs_emit_at(buf, n, "SNR = %d\n", p->SNR);
+	n += sysfs_emit_at(buf, n, "ber = %d\n", p->ber);
+	n += sysfs_emit_at(buf, n, "FIB_CRC = %d\n", p->FIB_CRC);
+	n += sysfs_emit_at(buf, n, "ts_per = %d\n", p->ts_per);
+	n += sysfs_emit_at(buf, n, "MFER = %d\n", p->MFER);
+	n += sysfs_emit_at(buf, n, "RSSI = %d\n", p->RSSI);
+	n += sysfs_emit_at(buf, n, "in_band_pwr = %d\n", p->in_band_pwr);
+	n += sysfs_emit_at(buf, n, "carrier_offset = %d\n", p->carrier_offset);
+	n += sysfs_emit_at(buf, n, "modem_state = %d\n", p->modem_state);
+	n += sysfs_emit_at(buf, n, "frequency = %d\n", p->frequency);
+	n += sysfs_emit_at(buf, n, "bandwidth = %d\n", p->bandwidth);
+	n += sysfs_emit_at(buf, n, "transmission_mode = %d\n", p->transmission_mode);
+	n += sysfs_emit_at(buf, n, "modem_state = %d\n", p->modem_state);
+	n += sysfs_emit_at(buf, n, "guard_interval = %d\n", p->guard_interval);
+	n += sysfs_emit_at(buf, n, "code_rate = %d\n", p->code_rate);
+	n += sysfs_emit_at(buf, n, "lp_code_rate = %d\n", p->lp_code_rate);
+	n += sysfs_emit_at(buf, n, "hierarchy = %d\n", p->hierarchy);
+	n += sysfs_emit_at(buf, n, "constellation = %d\n", p->constellation);
+	n += sysfs_emit_at(buf, n, "burst_size = %d\n", p->burst_size);
+	n += sysfs_emit_at(buf, n, "burst_duration = %d\n", p->burst_duration);
+	n += sysfs_emit_at(buf, n, "burst_cycle_time = %d\n", p->burst_cycle_time);
+	n += sysfs_emit_at(buf, n, "calc_burst_cycle_time = %d\n", p->calc_burst_cycle_time);
+	n += sysfs_emit_at(buf, n, "num_of_rows = %d\n", p->num_of_rows);
+	n += sysfs_emit_at(buf, n, "num_of_padd_cols = %d\n", p->num_of_padd_cols);
+	n += sysfs_emit_at(buf, n, "num_of_punct_cols = %d\n", p->num_of_punct_cols);
+	n += sysfs_emit_at(buf, n, "error_ts_packets = %d\n", p->error_ts_packets);
+	n += sysfs_emit_at(buf, n, "total_ts_packets = %d\n", p->total_ts_packets);
+	n += sysfs_emit_at(buf, n, "num_of_valid_mpe_tlbs = %d\n", p->num_of_valid_mpe_tlbs);
+	n += sysfs_emit_at(buf, n, "num_of_invalid_mpe_tlbs = %d\n", p->num_of_invalid_mpe_tlbs);
+	n += sysfs_emit_at(buf, n, "num_of_corrected_mpe_tlbs = %d\n",
+			   p->num_of_corrected_mpe_tlbs);
+	n += sysfs_emit_at(buf, n, "ber_error_count = %d\n", p->ber_error_count);
+	n += sysfs_emit_at(buf, n, "ber_bit_count = %d\n", p->ber_bit_count);
+	n += sysfs_emit_at(buf, n, "sms_to_host_tx_errors = %d\n", p->sms_to_host_tx_errors);
+	n += sysfs_emit_at(buf, n, "pre_ber = %d\n", p->pre_ber);
+	n += sysfs_emit_at(buf, n, "cell_id = %d\n", p->cell_id);
+	n += sysfs_emit_at(buf, n, "dvbh_srv_ind_hp = %d\n", p->dvbh_srv_ind_hp);
+	n += sysfs_emit_at(buf, n, "dvbh_srv_ind_lp = %d\n", p->dvbh_srv_ind_lp);
+	n += sysfs_emit_at(buf, n, "num_mpe_received = %d\n", p->num_mpe_received);

 	debug_data->stats_count = n;
 	spin_unlock(&debug_data->lock);
@@ -148,78 +107,49 @@ static void smsdvb_print_isdb_stats(struct smsdvb_debugfs *debug_data,

 	buf = debug_data->stats_data;

-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "statistics_type = %d\t", p->statistics_type);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "full_size = %d\n", p->full_size);
-
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "is_rf_locked = %d\t\t", p->is_rf_locked);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "is_demod_locked = %d\t", p->is_demod_locked);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "is_external_lna_on = %d\n", p->is_external_lna_on);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "SNR = %d dB\t\t", p->SNR);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "RSSI = %d dBm\t\t", p->RSSI);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "in_band_pwr = %d dBm\n", p->in_band_pwr);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "carrier_offset = %d\t", p->carrier_offset);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "bandwidth = %d\t\t", p->bandwidth);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "frequency = %d Hz\n", p->frequency);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "transmission_mode = %d\t", p->transmission_mode);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "modem_state = %d\t\t", p->modem_state);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "guard_interval = %d\n", p->guard_interval);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "system_type = %d\t\t", p->system_type);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "partial_reception = %d\t", p->partial_reception);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "num_of_layers = %d\n", p->num_of_layers);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "sms_to_host_tx_errors = %d\n", p->sms_to_host_tx_errors);
+	n += sysfs_emit_at(buf, n, "statistics_type = %d\t", p->statistics_type);
+	n += sysfs_emit_at(buf, n, "full_size = %d\n", p->full_size);
+
+	n += sysfs_emit_at(buf, n, "is_rf_locked = %d\t\t", p->is_rf_locked);
+	n += sysfs_emit_at(buf, n, "is_demod_locked = %d\t", p->is_demod_locked);
+	n += sysfs_emit_at(buf, n, "is_external_lna_on = %d\n", p->is_external_lna_on);
+	n += sysfs_emit_at(buf, n, "SNR = %d dB\t\t", p->SNR);
+	n += sysfs_emit_at(buf, n, "RSSI = %d dBm\t\t", p->RSSI);
+	n += sysfs_emit_at(buf, n, "in_band_pwr = %d dBm\n", p->in_band_pwr);
+	n += sysfs_emit_at(buf, n, "carrier_offset = %d\t", p->carrier_offset);
+	n += sysfs_emit_at(buf, n, "bandwidth = %d\t\t", p->bandwidth);
+	n += sysfs_emit_at(buf, n, "frequency = %d Hz\n", p->frequency);
+	n += sysfs_emit_at(buf, n, "transmission_mode = %d\t", p->transmission_mode);
+	n += sysfs_emit_at(buf, n, "modem_state = %d\t\t", p->modem_state);
+	n += sysfs_emit_at(buf, n, "guard_interval = %d\n", p->guard_interval);
+	n += sysfs_emit_at(buf, n, "system_type = %d\t\t", p->system_type);
+	n += sysfs_emit_at(buf, n, "partial_reception = %d\t", p->partial_reception);
+	n += sysfs_emit_at(buf, n, "num_of_layers = %d\n", p->num_of_layers);
+	n += sysfs_emit_at(buf, n, "sms_to_host_tx_errors = %d\n", p->sms_to_host_tx_errors);

 	for (i = 0; i < 3; i++) {
 		if (p->layer_info[i].number_of_segments < 1 ||
 		    p->layer_info[i].number_of_segments > 13)
 			continue;

-		n += scnprintf(&buf[n], PAGE_SIZE - n, "\nLayer %d\n", i);
-		n += scnprintf(&buf[n], PAGE_SIZE - n, "\tcode_rate = %d\t",
-			      p->layer_info[i].code_rate);
-		n += scnprintf(&buf[n], PAGE_SIZE - n, "constellation = %d\n",
-			      p->layer_info[i].constellation);
-		n += scnprintf(&buf[n], PAGE_SIZE - n, "\tber = %-5d\t",
-			      p->layer_info[i].ber);
-		n += scnprintf(&buf[n], PAGE_SIZE - n,
-			      "\tber_error_count = %-5d\t",
-			      p->layer_info[i].ber_error_count);
-		n += scnprintf(&buf[n], PAGE_SIZE - n, "ber_bit_count = %-5d\n",
-			      p->layer_info[i].ber_bit_count);
-		n += scnprintf(&buf[n], PAGE_SIZE - n, "\tpre_ber = %-5d\t",
-			      p->layer_info[i].pre_ber);
-		n += scnprintf(&buf[n], PAGE_SIZE - n, "\tts_per = %-5d\n",
-			      p->layer_info[i].ts_per);
-		n += scnprintf(&buf[n], PAGE_SIZE - n,
-			      "\terror_ts_packets = %-5d\t",
-			      p->layer_info[i].error_ts_packets);
-		n += scnprintf(&buf[n], PAGE_SIZE - n,
-			      "total_ts_packets = %-5d\t",
-			      p->layer_info[i].total_ts_packets);
-		n += scnprintf(&buf[n], PAGE_SIZE - n, "ti_ldepth_i = %d\n",
-			      p->layer_info[i].ti_ldepth_i);
-		n += scnprintf(&buf[n], PAGE_SIZE - n,
-			      "\tnumber_of_segments = %d\t",
-			      p->layer_info[i].number_of_segments);
-		n += scnprintf(&buf[n], PAGE_SIZE - n, "tmcc_errors = %d\n",
-			      p->layer_info[i].tmcc_errors);
+		n += sysfs_emit_at(buf, n, "\nLayer %d\n", i);
+		n += sysfs_emit_at(buf, n, "\tcode_rate = %d\t", p->layer_info[i].code_rate);
+		n += sysfs_emit_at(buf, n, "constellation = %d\n", p->layer_info[i].constellation);
+		n += sysfs_emit_at(buf, n, "\tber = %-5d\t", p->layer_info[i].ber);
+		n += sysfs_emit_at(buf, n, "\tber_error_count = %-5d\t",
+				   p->layer_info[i].ber_error_count);
+		n += sysfs_emit_at(buf, n, "ber_bit_count = %-5d\n",
+				   p->layer_info[i].ber_bit_count);
+		n += sysfs_emit_at(buf, n, "\tpre_ber = %-5d\t", p->layer_info[i].pre_ber);
+		n += sysfs_emit_at(buf, n, "\tts_per = %-5d\n", p->layer_info[i].ts_per);
+		n += sysfs_emit_at(buf, n, "\terror_ts_packets = %-5d\t",
+				   p->layer_info[i].error_ts_packets);
+		n += sysfs_emit_at(buf, n, "total_ts_packets = %-5d\t",
+				   p->layer_info[i].total_ts_packets);
+		n += sysfs_emit_at(buf, n, "ti_ldepth_i = %d\n", p->layer_info[i].ti_ldepth_i);
+		n += sysfs_emit_at(buf, n, "\tnumber_of_segments = %d\t",
+				   p->layer_info[i].number_of_segments);
+		n += sysfs_emit_at(buf, n, "tmcc_errors = %d\n", p->layer_info[i].tmcc_errors);
 	}

 	debug_data->stats_count = n;
@@ -241,80 +171,50 @@ static void smsdvb_print_isdb_stats_ex(struct smsdvb_debugfs *debug_data,

 	buf = debug_data->stats_data;

-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "statistics_type = %d\t", p->statistics_type);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "full_size = %d\n", p->full_size);
-
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "is_rf_locked = %d\t\t", p->is_rf_locked);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "is_demod_locked = %d\t", p->is_demod_locked);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "is_external_lna_on = %d\n", p->is_external_lna_on);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "SNR = %d dB\t\t", p->SNR);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "RSSI = %d dBm\t\t", p->RSSI);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "in_band_pwr = %d dBm\n", p->in_band_pwr);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "carrier_offset = %d\t", p->carrier_offset);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "bandwidth = %d\t\t", p->bandwidth);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "frequency = %d Hz\n", p->frequency);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "transmission_mode = %d\t", p->transmission_mode);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "modem_state = %d\t\t", p->modem_state);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "guard_interval = %d\n", p->guard_interval);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "system_type = %d\t\t", p->system_type);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "partial_reception = %d\t", p->partial_reception);
-	n += scnprintf(&buf[n], PAGE_SIZE - n,
-		      "num_of_layers = %d\n", p->num_of_layers);
-	n += scnprintf(&buf[n], PAGE_SIZE - n, "segment_number = %d\t",
-		      p->segment_number);
-	n += scnprintf(&buf[n], PAGE_SIZE - n, "tune_bw = %d\n",
-		      p->tune_bw);
+	n += sysfs_emit_at(buf, n, "statistics_type = %d\t", p->statistics_type);
+	n += sysfs_emit_at(buf, n, "full_size = %d\n", p->full_size);
+
+	n += sysfs_emit_at(buf, n, "is_rf_locked = %d\t\t", p->is_rf_locked);
+	n += sysfs_emit_at(buf, n, "is_demod_locked = %d\t", p->is_demod_locked);
+	n += sysfs_emit_at(buf, n, "is_external_lna_on = %d\n", p->is_external_lna_on);
+	n += sysfs_emit_at(buf, n, "SNR = %d dB\t\t", p->SNR);
+	n += sysfs_emit_at(buf, n, "RSSI = %d dBm\t\t", p->RSSI);
+	n += sysfs_emit_at(buf, n, "in_band_pwr = %d dBm\n", p->in_band_pwr);
+	n += sysfs_emit_at(buf, n, "carrier_offset = %d\t", p->carrier_offset);
+	n += sysfs_emit_at(buf, n, "bandwidth = %d\t\t", p->bandwidth);
+	n += sysfs_emit_at(buf, n, "frequency = %d Hz\n", p->frequency);
+	n += sysfs_emit_at(buf, n, "transmission_mode = %d\t", p->transmission_mode);
+	n += sysfs_emit_at(buf, n, "modem_state = %d\t\t", p->modem_state);
+	n += sysfs_emit_at(buf, n, "guard_interval = %d\n", p->guard_interval);
+	n += sysfs_emit_at(buf, n, "system_type = %d\t\t", p->system_type);
+	n += sysfs_emit_at(buf, n, "partial_reception = %d\t", p->partial_reception);
+	n += sysfs_emit_at(buf, n, "num_of_layers = %d\n", p->num_of_layers);
+	n += sysfs_emit_at(buf, n, "segment_number = %d\t", p->segment_number);
+	n += sysfs_emit_at(buf, n, "tune_bw = %d\n", p->tune_bw);

 	for (i = 0; i < 3; i++) {
 		if (p->layer_info[i].number_of_segments < 1 ||
 		    p->layer_info[i].number_of_segments > 13)
 			continue;

-		n += scnprintf(&buf[n], PAGE_SIZE - n, "\nLayer %d\n", i);
-		n += scnprintf(&buf[n], PAGE_SIZE - n, "\tcode_rate = %d\t",
-			      p->layer_info[i].code_rate);
-		n += scnprintf(&buf[n], PAGE_SIZE - n, "constellation = %d\n",
-			      p->layer_info[i].constellation);
-		n += scnprintf(&buf[n], PAGE_SIZE - n, "\tber = %-5d\t",
-			      p->layer_info[i].ber);
-		n += scnprintf(&buf[n], PAGE_SIZE - n,
-			      "\tber_error_count = %-5d\t",
-			      p->layer_info[i].ber_error_count);
-		n += scnprintf(&buf[n], PAGE_SIZE - n, "ber_bit_count = %-5d\n",
-			      p->layer_info[i].ber_bit_count);
-		n += scnprintf(&buf[n], PAGE_SIZE - n, "\tpre_ber = %-5d\t",
-			      p->layer_info[i].pre_ber);
-		n += scnprintf(&buf[n], PAGE_SIZE - n, "\tts_per = %-5d\n",
-			      p->layer_info[i].ts_per);
-		n += scnprintf(&buf[n], PAGE_SIZE - n,
-			      "\terror_ts_packets = %-5d\t",
-			      p->layer_info[i].error_ts_packets);
-		n += scnprintf(&buf[n], PAGE_SIZE - n,
-			      "total_ts_packets = %-5d\t",
-			      p->layer_info[i].total_ts_packets);
-		n += scnprintf(&buf[n], PAGE_SIZE - n, "ti_ldepth_i = %d\n",
-			      p->layer_info[i].ti_ldepth_i);
-		n += scnprintf(&buf[n], PAGE_SIZE - n,
-			      "\tnumber_of_segments = %d\t",
-			      p->layer_info[i].number_of_segments);
-		n += scnprintf(&buf[n], PAGE_SIZE - n, "tmcc_errors = %d\n",
-			      p->layer_info[i].tmcc_errors);
+		n += sysfs_emit_at(buf, n, "\nLayer %d\n", i);
+		n += sysfs_emit_at(buf, n, "\tcode_rate = %d\t", p->layer_info[i].code_rate);
+		n += sysfs_emit_at(buf, n, "constellation = %d\n", p->layer_info[i].constellation);
+		n += sysfs_emit_at(buf, n, "\tber = %-5d\t", p->layer_info[i].ber);
+		n += sysfs_emit_at(buf, n, "\tber_error_count = %-5d\t",
+				   p->layer_info[i].ber_error_count);
+		n += sysfs_emit_at(buf, n, "ber_bit_count = %-5d\n",
+				   p->layer_info[i].ber_bit_count);
+		n += sysfs_emit_at(buf, n, "\tpre_ber = %-5d\t", p->layer_info[i].pre_ber);
+		n += sysfs_emit_at(buf, n, "\tts_per = %-5d\n", p->layer_info[i].ts_per);
+		n += sysfs_emit_at(buf, n, "\terror_ts_packets = %-5d\t",
+				   p->layer_info[i].error_ts_packets);
+		n += sysfs_emit_at(buf, n, "total_ts_packets = %-5d\t",
+				   p->layer_info[i].total_ts_packets);
+		n += sysfs_emit_at(buf, n, "ti_ldepth_i = %d\n", p->layer_info[i].ti_ldepth_i);
+		n += sysfs_emit_at(buf, n, "\tnumber_of_segments = %d\t",
+				   p->layer_info[i].number_of_segments);
+		n += sysfs_emit_at(buf, n, "tmcc_errors = %d\n", p->layer_info[i].tmcc_errors);
 	}


-- 
2.25.1
