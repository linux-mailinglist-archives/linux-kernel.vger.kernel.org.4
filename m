Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF04735D55
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjFSSM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFSSMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:12:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33484E4D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:12:51 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b477e9d396so20681051fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687198369; x=1689790369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIC5OCFcaIkjdFrGg7yRkrVHCEbc8gY+YZsP4CSqvYo=;
        b=ITBI6X7O1B7uVPBo1qZL9XL8wH1m13Yiky5kXxOenoO/CgG/dnsi8xG62i10AOXfjV
         t+GHqEwdPu6wAQFl0M+uW8Cx6ZF23OLITC+M9Py2Vsgxn2xSQBdf3R033lAvwUqJPDbB
         x83buwldezJtOnZqn2kniYEHGFVgBvxJgrRNbtVikxgrHMO4r8F5UZwUEmxegrrVyvax
         /j9PY066uydHE6IEOQKEwrIVfupU9gSs/NSWel9Bbc3U5K4zYCrE3tJ5KK/5CLYdMC7q
         ZhdkDFB6udxhvIdZ5K+oS1pqAEWoH5myyPTeOyngLbjAIxM1BkfMtg5pGizLD4UYlU7T
         Bbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687198369; x=1689790369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIC5OCFcaIkjdFrGg7yRkrVHCEbc8gY+YZsP4CSqvYo=;
        b=EBGxumMskUIRuxbESJ7w3jaNKOw+g+tDKw7eDcSH4k30rCz60mScH9YqkZcCbOgt0g
         YHcOFgxPg0iiTkHrdjZMVYnL+JPUn/jB68vMTX4A8yuDQJ7pGwgg13mRtbqo+bfRVKbK
         HIOv7zwuWah9ObZzzGN6teLKmefi3AXx4qSrmJBvWVuxdKf2G30qoy2Q8444G54Vf2hX
         EtCROEy5RlPrXn++M4zTCAY9FiQaA9FI+8lqLfi9xb5cNEzId/HwWWuIGi5taw5kb/DN
         sqcTqD2YXvOmqDbUy8Ymwz06foL/i7KBDSl4qIWD68zkJtQMmIqu0r2TDu4g6Sa8dRKg
         ohEg==
X-Gm-Message-State: AC+VfDwe32Igiy4PMMeO3ibudBE6iuTNdJAw8CU0u3kI4G+lvu6UUQdh
        0QtJJLoJM55IbQFerga3zIo=
X-Google-Smtp-Source: ACHHUZ5V6Vxl9OK+64fr+JSP6NjRiiNQA6EFQRF7Zx04UgAsCfx4RHDrcn5ulpgSvbFFV1sRJ6nTxw==
X-Received: by 2002:a2e:9147:0:b0:2b4:62ad:3c33 with SMTP id q7-20020a2e9147000000b002b462ad3c33mr4845895ljg.25.1687198369278;
        Mon, 19 Jun 2023 11:12:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:dcda:2154:7873:34])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906828b00b00965a4350411sm41021ejx.9.2023.06.19.11.12.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Jun 2023 11:12:48 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     franziska.naepelt@googlemail.com
Cc:     eperi1024@gmail.com, franziska.naepelt@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, quic_vjakkam@quicinc.com,
        tegongkang@gmail.com
Subject: [PATCH 4/5] staging: rtl8723bs: Fix blank line issues
Date:   Mon, 19 Jun 2023 20:12:46 +0200
Message-Id: <20230619181246.19112-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230619175703.18826-1-franziska.naepelt@gmail.com>
References: <20230619175703.18826-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch blank line issues:
- CHECK: Please don't use multiple blank lines
- CHECK: Blank lines aren't necessary before a close brace '}'
- CHECK: Blank lines aren't necessary after an open brace '{'

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 46 -------------------
 1 file changed, 46 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index b65b5372bbcb..c00a377258d8 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -304,7 +304,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	memcpy(pwlanhdr->addr2, pnetwork->network.mac_address, ETH_ALEN);
 	memcpy(pwlanhdr->addr3, pnetwork->network.mac_address, ETH_ALEN);
 
-
 	pbuf += sizeof(struct ieee80211_hdr_3addr);
 	len = sizeof(struct ieee80211_hdr_3addr);
 
@@ -324,7 +323,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 
 exit:
 	return bss;
-
 }
 
 /*
@@ -373,7 +371,6 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 		struct wlan_network *scanned = pmlmepriv->cur_network_scanned;
 
 		if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) {
-
 			memcpy(&cur_network->network, pnetwork, sizeof(struct wlan_bssid_ex));
 			rtw_cfg80211_inform_bss(padapter, cur_network);
 		} else {
@@ -494,7 +491,6 @@ void rtw_cfg80211_indicate_disconnect(struct adapter *padapter)
 	}
 }
 
-
 static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_param *param, u32 param_len)
 {
 	int ret = 0;
@@ -568,7 +564,6 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 		rtw_ap_set_wep_key(padapter, param->u.crypt.key, wep_key_len, wep_key_idx, 1);
 
 		goto exit;
-
 	}
 
 	/* group key */
@@ -615,11 +610,9 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 				pbcmc_sta->ieee8021x_blocked = false;
 				pbcmc_sta->dot118021XPrivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021XPrivacy */
 			}
-
 		}
 
 		goto exit;
-
 	}
 
 	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X && psta) { /*  psk/802_1x */
@@ -642,7 +635,6 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 					psecuritypriv->busetkipkey = true;
 
 				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
-
 					psta->dot118021XPrivacy = _AES_;
 				} else {
 					psta->dot118021XPrivacy = _NO_PRIVACY_;
@@ -694,17 +686,13 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 					pbcmc_sta->ieee8021x_blocked = false;
 					pbcmc_sta->dot118021XPrivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021XPrivacy */
 				}
-
 			}
-
 		}
-
 	}
 
 exit:
 
 	return ret;
-
 }
 
 static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param *param, u32 param_len)
@@ -788,7 +776,6 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 				if (strcmp(param->u.crypt.alg, "none") != 0)
 					psta->ieee8021x_blocked = false;
 
-
 				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
 						(padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
 					psta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
@@ -899,7 +886,6 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 
 	strncpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
 
-
 	if (!mac_addr || is_broadcast_ether_addr(mac_addr))
 		param->u.crypt.set_tx = 0; /* for wpa/wpa2 group key */
 	else
@@ -931,7 +917,6 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	kfree(param);
 
 	return ret;
-
 }
 
 static int cfg80211_rtw_get_key(struct wiphy *wiphy, struct net_device *ndev,
@@ -982,7 +967,6 @@ static int cfg80211_rtw_set_default_key(struct wiphy *wiphy,
 	}
 
 	return 0;
-
 }
 
 static int cfg80211_rtw_get_station(struct wiphy *wiphy,
@@ -1167,7 +1151,6 @@ void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter)
 			/* ev =translate_scan(padapter, a, pnetwork, ev, stop); */
 			rtw_cfg80211_inform_bss(padapter, pnetwork);
 		}
-
 	}
 
 	spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
@@ -1199,7 +1182,6 @@ static int rtw_cfg80211_set_probe_req_wpsp2pie(struct adapter *padapter, char *b
 	}
 
 	return ret;
-
 }
 
 static int cfg80211_rtw_scan(struct wiphy *wiphy
@@ -1311,7 +1293,6 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	}
 	spin_unlock_bh(&pmlmepriv->lock);
 
-
 	if (_status == false)
 		ret = -1;
 
@@ -1326,7 +1307,6 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 
 exit:
 	return ret;
-
 }
 
 static int cfg80211_rtw_set_wiphy_params(struct wiphy *wiphy, u32 changed)
@@ -1341,12 +1321,10 @@ static int rtw_cfg80211_set_wpa_version(struct security_priv *psecuritypriv, u32
 		return 0;
 	}
 
-
 	if (wpa_version & (NL80211_WPA_VERSION_1 | NL80211_WPA_VERSION_2))
 		psecuritypriv->ndisauthtype = Ndis802_11AuthModeWPAPSK;
 
 	return 0;
-
 }
 
 static int rtw_cfg80211_set_auth_type(struct security_priv *psecuritypriv,
@@ -1372,7 +1350,6 @@ static int rtw_cfg80211_set_auth_type(struct security_priv *psecuritypriv,
 
 		psecuritypriv->ndisencryptstatus = Ndis802_11Encryption1Enabled;
 
-
 		break;
 	default:
 		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
@@ -1380,7 +1357,6 @@ static int rtw_cfg80211_set_auth_type(struct security_priv *psecuritypriv,
 	}
 
 	return 0;
-
 }
 
 static int rtw_cfg80211_set_cipher(struct security_priv *psecuritypriv, u32 cipher, bool ucast)
@@ -1390,7 +1366,6 @@ static int rtw_cfg80211_set_cipher(struct security_priv *psecuritypriv, u32 ciph
 	u32 *profile_cipher = ucast ? &psecuritypriv->dot11PrivacyAlgrthm :
 		&psecuritypriv->dot118021XGrpPrivacy;
 
-
 	if (!cipher) {
 		*profile_cipher = _NO_PRIVACY_;
 		psecuritypriv->ndisencryptstatus = ndisencryptstatus;
@@ -1602,7 +1577,6 @@ static int cfg80211_rtw_join_ibss(struct wiphy *wiphy, struct net_device *ndev,
 	}
 
 	if (params->ssid_len > IW_ESSID_MAX_SIZE) {
-
 		ret = -E2BIG;
 		goto exit;
 	}
@@ -1670,7 +1644,6 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 
 	padapter->mlmepriv.not_indic_disco = true;
 
-
 	if (adapter_wdev_data(padapter)->block == true) {
 		ret = -EBUSY;
 		goto exit;
@@ -1693,7 +1666,6 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 	}
 
 	if (sme->ssid_len > IW_ESSID_MAX_SIZE) {
-
 		ret = -E2BIG;
 		goto exit;
 	}
@@ -1888,7 +1860,6 @@ static int cfg80211_rtw_set_pmksa(struct wiphy *wiphy,
 	/* overwrite PMKID */
 	for (index = 0 ; index < NUM_PMKID_CACHE; index++) {
 		if (!memcmp(psecuritypriv->PMKIDList[index].Bssid, (u8 *)pmksa->bssid, ETH_ALEN)) {
-
 			memcpy(psecuritypriv->PMKIDList[index].PMKID, (u8 *)pmksa->pmkid, WLAN_PMKID_LEN);
 			psecuritypriv->PMKIDList[index].bUsed = true;
 			psecuritypriv->PMKIDIndex = index + 1;
@@ -1898,7 +1869,6 @@ static int cfg80211_rtw_set_pmksa(struct wiphy *wiphy,
 	}
 
 	if (!blInserted) {
-
 		memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].Bssid, (u8 *)pmksa->bssid, ETH_ALEN);
 		memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].PMKID, (u8 *)pmksa->pmkid, WLAN_PMKID_LEN);
 
@@ -2134,11 +2104,9 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 		pattrib->seqnum = pmlmeext->mgnt_seq;
 		pmlmeext->mgnt_seq++;
 
-
 		pattrib->last_txcmdsz = pattrib->pktlen;
 
 		dump_mgntframe(padapter, pmgntframe);
-
 	}
 
 fail:
@@ -2146,11 +2114,8 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 	dev_kfree_skb_any(skb);
 
 	return NETDEV_TX_OK;
-
 }
 
-
-
 static const struct net_device_ops rtw_cfg80211_monitor_if_ops = {
 	.ndo_start_xmit = rtw_cfg80211_monitor_if_xmit_entry,
 };
@@ -2323,7 +2288,6 @@ static int rtw_add_beacon(struct adapter *adapter, const u8 *head, size_t head_l
 	else
 		ret = -EINVAL;
 
-
 	kfree(pbuf);
 
 	return ret;
@@ -2403,7 +2367,6 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 		return -EINVAL;
 	}
 
-
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 
 	phead = &pstapriv->asoc_list;
@@ -2422,9 +2385,7 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 
 				break;
 			}
-
 		}
-
 	}
 
 	spin_unlock_bh(&pstapriv->asoc_list_lock);
@@ -2432,7 +2393,6 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 	associated_clients_update(padapter, updated);
 
 	return ret;
-
 }
 
 static int cfg80211_rtw_change_station(struct wiphy *wiphy, struct net_device *ndev,
@@ -2464,7 +2424,6 @@ static struct sta_info *rtw_sta_info_get_by_idx(const int idx, struct sta_priv *
 static int	cfg80211_rtw_dump_station(struct wiphy *wiphy, struct net_device *ndev,
 			       int idx, u8 *mac, struct station_info *sinfo)
 {
-
 	int ret = 0;
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 	struct sta_info *psta = NULL;
@@ -2567,7 +2526,6 @@ static int _cfg80211_rtw_mgmt_tx(struct adapter *padapter, u8 tx_ch, const u8 *b
 exit:
 
 	return ret;
-
 }
 
 static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
@@ -2639,7 +2597,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 
 static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum nl80211_band band)
 {
-
 #define MAX_BIT_RATE_40MHZ_MCS15	300	/* Mbps */
 #define MAX_BIT_RATE_40MHZ_MCS7		150	/* Mbps */
 
@@ -2691,12 +2648,10 @@ void rtw_cfg80211_init_wiphy(struct adapter *padapter)
 
 	/* copy mac_addr to wiphy */
 	memcpy(wiphy->perm_addr, padapter->eeprompriv.mac_addr, ETH_ALEN);
-
 }
 
 static void rtw_cfg80211_preinit_wiphy(struct adapter *padapter, struct wiphy *wiphy)
 {
-
 	wiphy->signal_type = CFG80211_SIGNAL_TYPE_MBM;
 
 	wiphy->max_scan_ssids = RTW_SSID_SCAN_AMOUNT;
@@ -2843,7 +2798,6 @@ int rtw_wdev_alloc(struct adapter *padapter, struct device *dev)
 	wiphy_free(wiphy);
 exit:
 	return ret;
-
 }
 
 void rtw_wdev_free(struct wireless_dev *wdev)
-- 
2.39.2 (Apple Git-143)

