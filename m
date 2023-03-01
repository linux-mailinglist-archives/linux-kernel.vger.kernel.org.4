Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0806A6735
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 06:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCAFAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 00:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCAFAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 00:00:15 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EDB31E3A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 21:00:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id h16so48995618edz.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 21:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677646812;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XUQml6mB6fyElWn5fahuEubA6/oRTgl8hnq3v9WlNo=;
        b=LcBCQcqKE1J8v+3Jd8o7twV9tvZ5mwFaQMMyMOdYjiYwYZPdfmtL9z2ouiXMbzJKvt
         r2WTKLB8vc6/SL76Ky28oM3rNx2PkEPnXxVt+DGJOaYyIH3C6msLBqRrD7ECsFf1aupy
         GtgPxWZPx+zCj5k7kQrzxeNWa+9IOh71NOMDZC70IIHQ++9QOo3T1Elyo6kv0azuBVpJ
         /l+LGiiOLAWlidRXdDFxen1KFp06GZbUMC4UCTBF/giRMrsH99kLc1ZLKfh52MCJbyZT
         gzLps63yZZGUB2pWWdgN2smf99n3FN7ExHIg+yxCIvyKevDhpYyOw8U7LyaWtxtpaUhU
         6xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677646812;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XUQml6mB6fyElWn5fahuEubA6/oRTgl8hnq3v9WlNo=;
        b=fsNe6CjVHgZ2nHu7g5m4nQg5UMpBy2csQ/+mwv3nrR8jhj0TyNB24hO+poReyXrdv4
         l+T2GVXIjxJbSbFuhrpSYoAiQWznGMsEJgeeobwE4Iqowgw/SYd+yEwcl59gXdMOnLGy
         oTgSRQvYPZwFBml1DoBqrQK4PpOBjAGWvMglO2GdZL44uaEvFY98YlLC6j2EXRXlYxCp
         XpopGLCYzuh4xNmn/5PB5JyBdykdDsMIjKIP4zcQ8SL5JtgDO8xRlljmzRzOtD0Rn2jI
         nhK1FcmsmNBkDhkhTebF2JUaXcoN0Cp2qPH7EAojVbJ0HSbgEAzYGfP6za6IPnDOTcuj
         bUDw==
X-Gm-Message-State: AO0yUKV71Vs1G/hjRgYpJKEpASlyi+kubgWcuW/JlSMUvGNgDLYPBFfu
        QAf1CQvZH+B1izVHStzwUC4=
X-Google-Smtp-Source: AK7set/ZO69aTBKO5vnuvPpDlhnkEum3ye8i7RIFRWjDXxAkY7gyhlmcT68is9ayH7VQIEA7vJl6uQ==
X-Received: by 2002:a17:906:1441:b0:8ae:e82a:3230 with SMTP id q1-20020a170906144100b008aee82a3230mr5345367ejc.70.1677646811712;
        Tue, 28 Feb 2023 21:00:11 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id mf27-20020a170906cb9b00b008b1fc5abd0esm5278354ejb.71.2023.02.28.21.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 21:00:11 -0800 (PST)
Date:   Wed, 1 Mar 2023 08:00:07 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: drivers/net/ethernet/intel/ice/ice_txrx.c:1304 ice_clean_rx_irq()
 error: uninitialized symbol 'cached_ntu'.
Message-ID: <202303011231.SEfXSwLT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c0927a7a5391f7d8e593e5e50ead7505a23cadf9
commit: 3246a10752a7120878740f345f3956997777b3d6 ice: Add support for XDP multi-buffer on Tx side
config: x86_64-randconfig-m001-20230227 (https://download.01.org/0day-ci/archive/20230301/202303011231.SEfXSwLT-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303011231.SEfXSwLT-lkp@intel.com/

New smatch warnings:
drivers/net/ethernet/intel/ice/ice_txrx.c:1304 ice_clean_rx_irq() error: uninitialized symbol 'cached_ntu'.

vim +/cached_ntu +1304 drivers/net/ethernet/intel/ice/ice_txrx.c

efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1150  
eb087cd828648d Maciej Fijalkowski     2021-08-19  1151  	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
3246a10752a712 Maciej Fijalkowski     2023-01-31  1152  	if (xdp_prog) {
eb087cd828648d Maciej Fijalkowski     2021-08-19  1153  		xdp_ring = rx_ring->xdp_ring;
3246a10752a712 Maciej Fijalkowski     2023-01-31  1154  		cached_ntu = xdp_ring->next_to_use;
3246a10752a712 Maciej Fijalkowski     2023-01-31  1155  	}

Uninitialized on else path.

eb087cd828648d Maciej Fijalkowski     2021-08-19  1156  
f9867df6d96593 Anirudh Venkataramanan 2019-02-19  1157  	/* start the loop to process Rx packets bounded by 'budget' */
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1158  	while (likely(total_rx_pkts < (unsigned int)budget)) {
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1159  		union ice_32b_rx_flex_desc *rx_desc;
6c869cb7a8f02b Maciej Fijalkowski     2019-02-13  1160  		struct ice_rx_buf *rx_buf;
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1161  		struct sk_buff *skb;
6c869cb7a8f02b Maciej Fijalkowski     2019-02-13  1162  		unsigned int size;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1163  		u16 stat_err_bits;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1164  		u16 vlan_tag = 0;
dda90cb90a5ced Jesse Brandeburg       2021-02-23  1165  		u16 rx_ptype;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1166  
f9867df6d96593 Anirudh Venkataramanan 2019-02-19  1167  		/* get the Rx desc from Rx ring based on 'next_to_clean' */
d7956d81f1502d Maciej Fijalkowski     2023-01-31  1168  		rx_desc = ICE_RX_DESC(rx_ring, ntc);
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1169  
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1170  		/* status_error_len will always be zero for unused descriptors
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1171  		 * because it's cleared in cleanup, and overlaps with hdr_addr
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1172  		 * which is always zero because packet split isn't used, if the
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1173  		 * hardware wrote DD then it will be non-zero
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1174  		 */
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1175  		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_DD_S);
0d54d8f7a16de0 Brett Creeley          2021-12-02  1176  		if (!ice_test_staterr(rx_desc->wb.status_error0, stat_err_bits))
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1177  			break;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1178  
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1179  		/* This memory barrier is needed to keep us from reading
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1180  		 * any other fields out of the rx_desc until we know the
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1181  		 * DD bit is set.
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1182  		 */
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1183  		dma_rmb();
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1184  
3089cf6d3caa1e Jesse Brandeburg       2021-06-08  1185  		ice_trace(clean_rx_irq, rx_ring, rx_desc);
148beb61203125 Henry Tieman           2020-05-11  1186  		if (rx_desc->wb.rxdid == FDIR_DESC_RXDID || !rx_ring->netdev) {
d6218317e2eff8 Qi Zhang               2021-03-09  1187  			struct ice_vsi *ctrl_vsi = rx_ring->vsi;
d6218317e2eff8 Qi Zhang               2021-03-09  1188  
d6218317e2eff8 Qi Zhang               2021-03-09  1189  			if (rx_desc->wb.rxdid == FDIR_DESC_RXDID &&
b03d519d3460f3 Jacob Keller           2022-02-16  1190  			    ctrl_vsi->vf)
d6218317e2eff8 Qi Zhang               2021-03-09  1191  				ice_vc_fdir_irq_handler(ctrl_vsi, rx_desc);
d7956d81f1502d Maciej Fijalkowski     2023-01-31  1192  			if (++ntc == cnt)
d7956d81f1502d Maciej Fijalkowski     2023-01-31  1193  				ntc = 0;
148beb61203125 Henry Tieman           2020-05-11  1194  			continue;
148beb61203125 Henry Tieman           2020-05-11  1195  		}
148beb61203125 Henry Tieman           2020-05-11  1196  
6c869cb7a8f02b Maciej Fijalkowski     2019-02-13  1197  		size = le16_to_cpu(rx_desc->wb.pkt_len) &
6c869cb7a8f02b Maciej Fijalkowski     2019-02-13  1198  			ICE_RX_FLX_DESC_PKT_LEN_M;
6c869cb7a8f02b Maciej Fijalkowski     2019-02-13  1199  
ac6f733a7bd5e2 Mitch Williams         2019-07-25  1200  		/* retrieve a buffer from the ring */
d7956d81f1502d Maciej Fijalkowski     2023-01-31  1201  		rx_buf = ice_get_rx_buf(rx_ring, size, ntc);
ac6f733a7bd5e2 Mitch Williams         2019-07-25  1202  
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1203  		if (!xdp->data) {
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1204  			void *hard_start;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1205  
be9df4aff65f18 Lorenzo Bianconi       2020-12-22  1206  			hard_start = page_address(rx_buf->page) + rx_buf->page_offset -
be9df4aff65f18 Lorenzo Bianconi       2020-12-22  1207  				     offset;
cb0473e0e9dcca Maciej Fijalkowski     2023-01-31  1208  			xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);
d4ecdbf7aa2fa4 Jesper Dangaard Brouer 2020-05-14  1209  #if (PAGE_SIZE > 4096)
d4ecdbf7aa2fa4 Jesper Dangaard Brouer 2020-05-14  1210  			/* At larger PAGE_SIZE, frame_sz depend on len size */
cb0473e0e9dcca Maciej Fijalkowski     2023-01-31  1211  			xdp->frame_sz = ice_rx_frame_truesize(rx_ring, size);
d4ecdbf7aa2fa4 Jesper Dangaard Brouer 2020-05-14  1212  #endif
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1213  			xdp_buff_clear_frags_flag(xdp);
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1214  		} else if (ice_add_xdp_frag(rx_ring, xdp, rx_buf, size)) {
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1215  			break;
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1216  		}
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1217  		if (++ntc == cnt)
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1218  			ntc = 0;
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1219  
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1220  		/* skip if it is NOP desc */
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1221  		if (ice_is_non_eop(rx_ring, rx_desc))
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1222  			continue;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1223  
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1224  		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf);
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1225  		if (rx_buf->act == ICE_XDP_PASS)
59bb0808055758 Maciej Fijalkowski     2019-10-24  1226  			goto construct_skb;
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1227  		total_rx_bytes += xdp_get_buff_len(xdp);
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1228  		total_rx_pkts++;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1229  
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1230  		xdp->data = NULL;
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1231  		rx_ring->first_desc = ntc;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1232  		continue;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1233  construct_skb:
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1234  		if (likely(ice_ring_uses_build_skb(rx_ring)))
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1235  			skb = ice_build_skb(rx_ring, xdp);
712edbbb67d404 Maciej Fijalkowski     2019-02-13  1236  		else
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1237  			skb = ice_construct_skb(rx_ring, xdp);
712edbbb67d404 Maciej Fijalkowski     2019-02-13  1238  		/* exit if we failed to retrieve a buffer */
712edbbb67d404 Maciej Fijalkowski     2019-02-13  1239  		if (!skb) {
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1240  			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1241  			rx_buf->act = ICE_XDP_CONSUMED;
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1242  			if (unlikely(xdp_buff_has_frags(xdp)))
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1243  				ice_set_rx_bufs_act(xdp, rx_ring,
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1244  						    ICE_XDP_CONSUMED);
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1245  			xdp->data = NULL;
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1246  			rx_ring->first_desc = ntc;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1247  			break;
712edbbb67d404 Maciej Fijalkowski     2019-02-13  1248  		}
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1249  		xdp->data = NULL;
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1250  		rx_ring->first_desc = ntc;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1251  
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1252  		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
0d54d8f7a16de0 Brett Creeley          2021-12-02  1253  		if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
0d54d8f7a16de0 Brett Creeley          2021-12-02  1254  					      stat_err_bits))) {
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1255  			dev_kfree_skb_any(skb);
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1256  			continue;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1257  		}
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1258  
0d54d8f7a16de0 Brett Creeley          2021-12-02  1259  		vlan_tag = ice_get_vlan_tag_from_rx_desc(rx_desc);
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1260  
133f4883f90668 Krzysztof Kazimierczak 2019-10-09  1261  		/* pad the skb if needed, to make a valid ethernet frame */
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1262  		if (eth_skb_pad(skb))
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1263  			continue;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1264  
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1265  		/* probably a little skewed due to removing CRC */
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1266  		total_rx_bytes += skb->len;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1267  
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1268  		/* populate checksum, VLAN, and protocol */
6503b659302893 Jesse Brandeburg       2019-08-08  1269  		rx_ptype = le16_to_cpu(rx_desc->wb.ptype_flex_flags0) &
6503b659302893 Jesse Brandeburg       2019-08-08  1270  			ICE_RX_FLEX_DESC_PTYPE_M;
6503b659302893 Jesse Brandeburg       2019-08-08  1271  
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1272  		ice_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1273  
3089cf6d3caa1e Jesse Brandeburg       2021-06-08  1274  		ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1275  		/* send completed skb up the stack */
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1276  		ice_receive_skb(rx_ring, skb, vlan_tag);
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1277  
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1278  		/* update budget accounting */
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1279  		total_rx_pkts++;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1280  	}
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1281  
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1282  	first = rx_ring->first_desc;
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1283  	while (cached_ntc != first) {
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1284  		struct ice_rx_buf *buf = &rx_ring->rx_buf[cached_ntc];
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1285  
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1286  		if (buf->act & (ICE_XDP_TX | ICE_XDP_REDIR)) {
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1287  			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1288  			xdp_xmit |= buf->act;
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1289  		} else if (buf->act & ICE_XDP_CONSUMED) {
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1290  			buf->pagecnt_bias++;
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1291  		} else if (buf->act == ICE_XDP_PASS) {
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1292  			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1293  		}
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1294  
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1295  		ice_put_rx_buf(rx_ring, buf);
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1296  		if (++cached_ntc >= cnt)
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1297  			cached_ntc = 0;
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1298  	}
d7956d81f1502d Maciej Fijalkowski     2023-01-31  1299  	rx_ring->next_to_clean = ntc;
cb7db35641c9a5 Brett Creeley          2019-06-26  1300  	/* return up to cleaned_count buffers to hardware */
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1301  	failure = ice_alloc_rx_bufs(rx_ring, ICE_RX_DESC_UNUSED(rx_ring));
cb7db35641c9a5 Brett Creeley          2019-06-26  1302  
9070fe3da0b126 Maciej Fijalkowski     2023-01-31  1303  	if (xdp_xmit)
3246a10752a712 Maciej Fijalkowski     2023-01-31 @1304  		ice_finalize_xdp_rx(xdp_ring, xdp_xmit, cached_ntu);
                                                                                                                ^^^^^^^^^^


efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1305  
288ecf491b1654 Benjamin Mikailenko    2022-11-18  1306  	if (rx_ring->ring_stats)
288ecf491b1654 Benjamin Mikailenko    2022-11-18  1307  		ice_update_rx_ring_stats(rx_ring, total_rx_pkts,
288ecf491b1654 Benjamin Mikailenko    2022-11-18  1308  					 total_rx_bytes);
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1309  
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1310  	/* guarantee a trip back through this routine if there was a failure */
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1311  	return failure ? budget : (int)total_rx_pkts;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1312  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

