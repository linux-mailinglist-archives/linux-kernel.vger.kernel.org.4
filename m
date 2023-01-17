Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5F2670C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjAQW7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjAQW6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:58:54 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77C525E0A;
        Tue, 17 Jan 2023 14:39:03 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z4-20020a17090a170400b00226d331390cso340065pjd.5;
        Tue, 17 Jan 2023 14:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=33qaMlSpVSfTyxfYMwgop2tKVyisw8uFsAvqqsaRdvk=;
        b=jnOaaN1ZJ+jI7rtdQVFeKIHLA5Bgl2QnrWRIpza+vVWBjGF9zqdyX2J97Ow4idXBKz
         PZCpKVssc/3kDibdFs2pni6XMth3G4DUPkJOHUv2PbuEEv2UYaqZSpZBGH4qddsEIue2
         3+C7p0ekGh7SZpJJzX9nFkTSuoVMkOqJkM5rLEV7DYFQCwm+eI0fECelUJUV5gCogcgu
         FLc136xOAxeDnxwY9UXbg1WyGGyGbC+cKBgMpXKvfGCNNNvU/n50NOzrtnhrXRJnpWPj
         F5OdBhdCZchMmNtBhTITsGauyIJkR6oLuQ0c6FOZ1E4e7B6mfcFzydestYXKpKvAF3S8
         QTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33qaMlSpVSfTyxfYMwgop2tKVyisw8uFsAvqqsaRdvk=;
        b=4/AwKoxdg8WPFzrc4knV+Q3Mv4iM9tL2OXLGJynqMlkvvC22gjkuIy+GN8mmaoyfzI
         Ksb+Ycw9VQ3H5qFpwJ9jcUMJiRXwpoO2Me5PZorFsnQsNtfanNVEPyYjTT+c0vczxvwr
         tFzIlgewCIEOQ9JBufzReyDR0aR2jqCKTFVOGxA//iCt0w0j3Ug7yagSMmavUCbj0eNA
         7eyJkWYaTXJdXLNkawR64YzmRdqOcXF6WMAlUWsV8YoaV9RYmqq12w3Z5QekhaO99/2g
         It/Gv7WrX3cSRVl3wF4ieyKW5ucSjgo7R0dvyePBcFptU2gqNyEpuwi/IKrzB43tlp6b
         eiLw==
X-Gm-Message-State: AFqh2kre4rIsWBGjTvxYjXypGyC+QSxXn8TtQ36x9Y9qnbu/jY2InAuZ
        1upeSksMcR3RPol4ymzb5VUtJiAQ0ylf+NAZ
X-Google-Smtp-Source: AMrXdXt4C6kjO2T6+c49XVLB0bVVMWwn7L5qESzp5w31Wgt7njrji5EcygySioKj07wy6DtQ25k9Qw==
X-Received: by 2002:a17:902:e810:b0:189:e577:c83d with SMTP id u16-20020a170902e81000b00189e577c83dmr6582470plg.66.1673995142869;
        Tue, 17 Jan 2023 14:39:02 -0800 (PST)
Received: from rishit-OMEN-Laptop-15-en0xxx ([171.76.81.196])
        by smtp.gmail.com with ESMTPSA id ix15-20020a170902f80f00b00192b23b8451sm21774791plb.108.2023.01.17.14.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:39:02 -0800 (PST)
Date:   Wed, 18 Jan 2023 04:08:58 +0530
From:   Rishit Bansal <rishitbansal0@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: hp-wmi: Handle Omen Key event
Message-ID: <Y8cjgu1ql+5+/NST@rishit-OMEN-Laptop-15-en0xxx>
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

Add support to map the "HP Omen Key" to KEY_PROG2. Laptops in the HP
Omen Series open the HP Omen Command Center application on windows. But,
on linux it fails with the following message from the hp-wmi driver:

[ 5143.415714] hp_wmi: Unknown event_id - 29 - 0x21a5

Signed-off-by: Rishit Bansal <rishitbansal0@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 0a99058be813..d8ba3c483901 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -91,6 +91,7 @@ enum hp_wmi_event_ids {
 	HPWMI_BATTERY_CHARGE_PERIOD	= 0x10,
 	HPWMI_SANITIZATION_MODE		= 0x17,
 	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
+	HPWMI_OMEN_KEY				= 0x1D,
 };
 
 /*
@@ -219,6 +220,7 @@ static const struct key_entry hp_wmi_keymap[] = {
 	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
 	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
 	{ KE_KEY, 0x231b,  { KEY_HELP } },
+	{ KE_KEY, 0x21a5,  { KEY_PROG2 }}, /* HP Omen Key */
 	{ KE_END, 0 }
 };
 
@@ -810,6 +812,7 @@ static void hp_wmi_notify(u32 value, void *context)
 	case HPWMI_SMART_ADAPTER:
 		break;
 	case HPWMI_BEZEL_BUTTON:
+	case HPWMI_OMEN_KEY:
 		key_code = hp_wmi_read_int(HPWMI_HOTKEY_QUERY);
 		if (key_code < 0)
 			break;
-- 
2.37.2

