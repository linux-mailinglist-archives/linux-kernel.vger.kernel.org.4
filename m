Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455E4738F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjFUSxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjFUSxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:53:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7681BDA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:53:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f918922954so39134805e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687373599; x=1689965599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6tRxvMyM9ZvLueS9fDkGIm5rePBPmA0VT04sZR8ac4=;
        b=XIL1q396vELEHTSUU8qBtnuRxryn4lrYe3abI1nmaVBhvbshi+/LLCKJXPzQqbJurE
         yPH/FN8Myb/w4Eb+hO39DjT1rSTolWZyvPsBUqG9v7zofULhAWvUIeNxTguEccDfbMmn
         KRcgXsWM2LeUCQJ+7dctLaJyVnCTBYRVkbCyXGbSEnaAzbm7BO/WwasvgA0TValI1mvS
         QrvCvEzXo+fxhn6wLGvS8UWIECsk23iZODF+6/mqU849VkUQk+ElFl+aIpFm/2eF22Ze
         hOGahHAPHtAbnRWjzsNb5C1ilTd2zbaHFKKi1RwKidHH4nlTGHBURL6GyTfhIw4gNwmZ
         gXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687373599; x=1689965599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6tRxvMyM9ZvLueS9fDkGIm5rePBPmA0VT04sZR8ac4=;
        b=BUnimu7Psphr4GElTqfuSuyao8PH3suTbT0NepL78FnGjVwRHBEs5FbQIBWoGUY6ZB
         BZTjEcN2qhrY7iqANqbb149wbH5i1p9oGRSmuxNqPOyMV0NeNTCIa+8h9pgfuuJ5ZD94
         3VknVkNdgf+2nEOI2u6JKcZVczJvX5dooZFovtRp660mygjtkSjKgpaCjHQ5fK7UN8JB
         1Q3EwwnKDAkGL1afh26FqGEE9Y3rGl1IRnRp31O+3HIhf4kUUnoe2Ww1QLHLIoX4fPgO
         lKeiBanROscxJaZm+hWE6SiQd+JV1SKDNAw2mRgQPsFoMnhiN4fpNroKOQ4V6P5QTyya
         ETHA==
X-Gm-Message-State: AC+VfDy2jwLUC/vbyQmqxOw00JutDv8o1CDiBprtKFe2Rj5W8akIslWY
        j02tlyPyg0Tw6jY+xftYjxk=
X-Google-Smtp-Source: ACHHUZ47eP2jmACfeOP7zPTJemepKM1upxam1UysMWV+x6sb+XI7Kc6z3bhrMjdKaF1NYbw39BueuQ==
X-Received: by 2002:a05:600c:211a:b0:3f6:e59:c04c with SMTP id u26-20020a05600c211a00b003f60e59c04cmr11251779wml.24.1687373598731;
        Wed, 21 Jun 2023 11:53:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:5d4c:afae:7fa:7038])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003f8fbe3bf7asm15062885wmq.32.2023.06.21.11.53.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Jun 2023 11:53:18 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     franziska.naepelt@googlemail.com
Cc:     eperi1024@gmail.com, franziska.naepelt@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, quic_vjakkam@quicinc.com,
        tegongkang@gmail.com
Subject: [PATCH v2 4/5] staging: rtl8723bs: Fix blank line issues
Date:   Wed, 21 Jun 2023 20:53:16 +0200
Message-Id: <20230621185316.25280-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230621184635.25064-1-franziska.naepelt@gmail.com>
References: <20230621184635.25064-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
v2: Fix additional blank line issue
---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 47 -------------------
 1 file changed, 47 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 3b64d0f1b4df..c00a377258d8 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -266,7 +266,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	}
 	/* spin_unlock_bh(&pwdev_priv->scan_req_lock); */

-
 	channel = pnetwork->network.configuration.ds_config;
 	freq = rtw_ieee80211_channel_to_frequency(channel, NL80211_BAND_2GHZ);

@@ -305,7 +304,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	memcpy(pwlanhdr->addr2, pnetwork->network.mac_address, ETH_ALEN);
 	memcpy(pwlanhdr->addr3, pnetwork->network.mac_address, ETH_ALEN);

-
 	pbuf += sizeof(struct ieee80211_hdr_3addr);
 	len = sizeof(struct ieee80211_hdr_3addr);

@@ -325,7 +323,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl

 exit:
 	return bss;
-
 }

 /*
@@ -374,7 +371,6 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 		struct wlan_network *scanned = pmlmepriv->cur_network_scanned;

 		if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) {
-
 			memcpy(&cur_network->network, pnetwork, sizeof(struct wlan_bssid_ex));
 			rtw_cfg80211_inform_bss(padapter, cur_network);
 		} else {
@@ -495,7 +491,6 @@ void rtw_cfg80211_indicate_disconnect(struct adapter *padapter)
 	}
 }

-
 static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_param *param, u32 param_len)
 {
 	int ret = 0;
@@ -569,7 +564,6 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 		rtw_ap_set_wep_key(padapter, param->u.crypt.key, wep_key_len, wep_key_idx, 1);

 		goto exit;
-
 	}

 	/* group key */
@@ -616,11 +610,9 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 				pbcmc_sta->ieee8021x_blocked = false;
 				pbcmc_sta->dot118021XPrivacy = psecuritypriv->dot118021XGrpPrivacy;/* rx will use bmc_sta's dot118021XPrivacy */
 			}
-
 		}

 		goto exit;
-
 	}

 	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X && psta) { /*  psk/802_1x */
@@ -643,7 +635,6 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 					psecuritypriv->busetkipkey = true;

 				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
-
 					psta->dot118021XPrivacy = _AES_;
 				} else {
 					psta->dot118021XPrivacy = _NO_PRIVACY_;
@@ -695,17 +686,13 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
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
@@ -789,7 +776,6 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 				if (strcmp(param->u.crypt.alg, "none") != 0)
 					psta->ieee8021x_blocked = false;

-
 				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
 						(padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
 					psta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
@@ -900,7 +886,6 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,

 	strncpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);

-
 	if (!mac_addr || is_broadcast_ether_addr(mac_addr))
 		param->u.crypt.set_tx = 0; /* for wpa/wpa2 group key */
 	else
@@ -932,7 +917,6 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	kfree(param);

 	return ret;
-
 }

 static int cfg80211_rtw_get_key(struct wiphy *wiphy, struct net_device *ndev,
@@ -983,7 +967,6 @@ static int cfg80211_rtw_set_default_key(struct wiphy *wiphy,
 	}

 	return 0;
-
 }

 static int cfg80211_rtw_get_station(struct wiphy *wiphy,
@@ -1168,7 +1151,6 @@ void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter)
 			/* ev =translate_scan(padapter, a, pnetwork, ev, stop); */
 			rtw_cfg80211_inform_bss(padapter, pnetwork);
 		}
-
 	}

 	spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
@@ -1200,7 +1182,6 @@ static int rtw_cfg80211_set_probe_req_wpsp2pie(struct adapter *padapter, char *b
 	}

 	return ret;
-
 }

 static int cfg80211_rtw_scan(struct wiphy *wiphy
@@ -1312,7 +1293,6 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	}
 	spin_unlock_bh(&pmlmepriv->lock);

-
 	if (_status == false)
 		ret = -1;

@@ -1327,7 +1307,6 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy

 exit:
 	return ret;
-
 }

 static int cfg80211_rtw_set_wiphy_params(struct wiphy *wiphy, u32 changed)
@@ -1342,12 +1321,10 @@ static int rtw_cfg80211_set_wpa_version(struct security_priv *psecuritypriv, u32
 		return 0;
 	}

-
 	if (wpa_version & (NL80211_WPA_VERSION_1 | NL80211_WPA_VERSION_2))
 		psecuritypriv->ndisauthtype = Ndis802_11AuthModeWPAPSK;

 	return 0;
-
 }

 static int rtw_cfg80211_set_auth_type(struct security_priv *psecuritypriv,
@@ -1373,7 +1350,6 @@ static int rtw_cfg80211_set_auth_type(struct security_priv *psecuritypriv,

 		psecuritypriv->ndisencryptstatus = Ndis802_11Encryption1Enabled;

-
 		break;
 	default:
 		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
@@ -1381,7 +1357,6 @@ static int rtw_cfg80211_set_auth_type(struct security_priv *psecuritypriv,
 	}

 	return 0;
-
 }

 static int rtw_cfg80211_set_cipher(struct security_priv *psecuritypriv, u32 cipher, bool ucast)
@@ -1391,7 +1366,6 @@ static int rtw_cfg80211_set_cipher(struct security_priv *psecuritypriv, u32 ciph
 	u32 *profile_cipher = ucast ? &psecuritypriv->dot11PrivacyAlgrthm :
 		&psecuritypriv->dot118021XGrpPrivacy;

-
 	if (!cipher) {
 		*profile_cipher = _NO_PRIVACY_;
 		psecuritypriv->ndisencryptstatus = ndisencryptstatus;
@@ -1603,7 +1577,6 @@ static int cfg80211_rtw_join_ibss(struct wiphy *wiphy, struct net_device *ndev,
 	}

 	if (params->ssid_len > IW_ESSID_MAX_SIZE) {
-
 		ret = -E2BIG;
 		goto exit;
 	}
@@ -1671,7 +1644,6 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,

 	padapter->mlmepriv.not_indic_disco = true;

-
 	if (adapter_wdev_data(padapter)->block == true) {
 		ret = -EBUSY;
 		goto exit;
@@ -1694,7 +1666,6 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 	}

 	if (sme->ssid_len > IW_ESSID_MAX_SIZE) {
-
 		ret = -E2BIG;
 		goto exit;
 	}
@@ -1889,7 +1860,6 @@ static int cfg80211_rtw_set_pmksa(struct wiphy *wiphy,
 	/* overwrite PMKID */
 	for (index = 0 ; index < NUM_PMKID_CACHE; index++) {
 		if (!memcmp(psecuritypriv->PMKIDList[index].Bssid, (u8 *)pmksa->bssid, ETH_ALEN)) {
-
 			memcpy(psecuritypriv->PMKIDList[index].PMKID, (u8 *)pmksa->pmkid, WLAN_PMKID_LEN);
 			psecuritypriv->PMKIDList[index].bUsed = true;
 			psecuritypriv->PMKIDIndex = index + 1;
@@ -1899,7 +1869,6 @@ static int cfg80211_rtw_set_pmksa(struct wiphy *wiphy,
 	}

 	if (!blInserted) {
-
 		memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].Bssid, (u8 *)pmksa->bssid, ETH_ALEN);
 		memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].PMKID, (u8 *)pmksa->pmkid, WLAN_PMKID_LEN);

@@ -2135,11 +2104,9 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 		pattrib->seqnum = pmlmeext->mgnt_seq;
 		pmlmeext->mgnt_seq++;

-
 		pattrib->last_txcmdsz = pattrib->pktlen;

 		dump_mgntframe(padapter, pmgntframe);
-
 	}

 fail:
@@ -2147,11 +2114,8 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 	dev_kfree_skb_any(skb);

 	return NETDEV_TX_OK;
-
 }

-
-
 static const struct net_device_ops rtw_cfg80211_monitor_if_ops = {
 	.ndo_start_xmit = rtw_cfg80211_monitor_if_xmit_entry,
 };
@@ -2324,7 +2288,6 @@ static int rtw_add_beacon(struct adapter *adapter, const u8 *head, size_t head_l
 	else
 		ret = -EINVAL;

-
 	kfree(pbuf);

 	return ret;
@@ -2404,7 +2367,6 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 		return -EINVAL;
 	}

-
 	spin_lock_bh(&pstapriv->asoc_list_lock);

 	phead = &pstapriv->asoc_list;
@@ -2423,9 +2385,7 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev

 				break;
 			}
-
 		}
-
 	}

 	spin_unlock_bh(&pstapriv->asoc_list_lock);
@@ -2433,7 +2393,6 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 	associated_clients_update(padapter, updated);

 	return ret;
-
 }

 static int cfg80211_rtw_change_station(struct wiphy *wiphy, struct net_device *ndev,
@@ -2465,7 +2424,6 @@ static struct sta_info *rtw_sta_info_get_by_idx(const int idx, struct sta_priv *
 static int	cfg80211_rtw_dump_station(struct wiphy *wiphy, struct net_device *ndev,
 			       int idx, u8 *mac, struct station_info *sinfo)
 {
-
 	int ret = 0;
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 	struct sta_info *psta = NULL;
@@ -2568,7 +2526,6 @@ static int _cfg80211_rtw_mgmt_tx(struct adapter *padapter, u8 tx_ch, const u8 *b
 exit:

 	return ret;
-
 }

 static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
@@ -2640,7 +2597,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,

 static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum nl80211_band band)
 {
-
 #define MAX_BIT_RATE_40MHZ_MCS15	300	/* Mbps */
 #define MAX_BIT_RATE_40MHZ_MCS7		150	/* Mbps */

@@ -2692,12 +2648,10 @@ void rtw_cfg80211_init_wiphy(struct adapter *padapter)

 	/* copy mac_addr to wiphy */
 	memcpy(wiphy->perm_addr, padapter->eeprompriv.mac_addr, ETH_ALEN);
-
 }

 static void rtw_cfg80211_preinit_wiphy(struct adapter *padapter, struct wiphy *wiphy)
 {
-
 	wiphy->signal_type = CFG80211_SIGNAL_TYPE_MBM;

 	wiphy->max_scan_ssids = RTW_SSID_SCAN_AMOUNT;
@@ -2844,7 +2798,6 @@ int rtw_wdev_alloc(struct adapter *padapter, struct device *dev)
 	wiphy_free(wiphy);
 exit:
 	return ret;
-
 }

 void rtw_wdev_free(struct wireless_dev *wdev)
--
2.39.2 (Apple Git-143)

