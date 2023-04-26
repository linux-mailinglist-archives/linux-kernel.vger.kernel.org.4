Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F73E6EF5AF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241201AbjDZNoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDZNom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:44:42 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080246A6F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:44:40 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MYe6H-1pnavA34xn-00Vh0J; Wed, 26 Apr 2023 15:39:15 +0200
Message-ID: <b1093de5-9f62-6714-0063-7c719dc4f6ca@i2se.com>
Date:   Wed, 26 Apr 2023 15:39:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Akira Shimahara <akira215corp@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        regressions@lists.linux.dev
From:   Stefan Wahren <stefan.wahren@i2se.com>
Subject: Regression: w1_therm: sysfs w1_slave sometimes report 85 degrees
 Celsius
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9+Vlw4+jn2N/v7j0vxMPWLyDRwGYp+CO/tXiR5tccEMsaSaH5aQ
 R9ecZ1Xs+q6sHX62lwerzUDDiNhj845FifgwpOZ1VJgSWCou2fvSfNe7+JpFVLNF1L0zSiD
 i2ZYBeApV27GGz95hWR/h2Hyj4YRG/zqPKVEEpmwjSV90jkFKMsB9LYvk6y7a3NmVh/4tX+
 +emoW4k2Y2WPqYNZ+5nCw==
UI-OutboundReport: notjunk:1;M01:P0:nk+SJ3Skr2A=;+cogvs2GoIuI9QE3rGVaSUzEYdT
 xrXADDJ/vaBxtZU4/iha4mOp4R4x04VC3Lhb9zw9hWbNgFtjFIAMGrcGfNndJbQrOk3I6sOWW
 h87w+0Xc7dFH+9FroUdFW1kS78tKyNnsUFuEC4VonnHwIbr6RtlDPd6KKEpZIPqRQ/jBBg/kS
 UYZkyedrO950gJevgliU73Wa4cwdgF1/rgiFC7lLHaHeaSE+9guiwWA6OWE/3QxuQZY2vYtcm
 kqJlB58C1NQxyAaMMn5dD8UT6YTXyk+3N24312z345S2Lf605UTlszZDw11yywO+gy3zDrJxO
 EjSxExsk2xct3MqHShIq5DiLjxoCRlKqO9u/dHv1YZrbts8/YK8FUFQWDOu3LV3t0R1UZy/Lm
 4TEytn5KT8CQCa8UFcMng+oyVjON411FtvVxiGOdfDc67T5KH0tGwaZs/z7c4ijnuQoc2QQSv
 aN6to0E7oviT4W5lXiYS/vlO/Bi4jYx7aFYaPDnglAyS8Rb3R+QJAjUQasr2UzAyesn9+HZfw
 fBdI0a9lwDLK9XAZQuy5XLiUOpB4mt6UI/zuIRUYj5ZryMmPiPd3+AcXld5gj+RXuNpxeXJ5d
 vFsTGR3H7/hPcRVMDYgV8lZF8Sy0hgeuDm2tQ079KeVcsBmAb6GHi9zE5dz7ixFjvzt5ag5yf
 WgGHAv5viGZWYsih8XXXQouA7/9wOJqFRA6Iy360pw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

recently we switch on our Tarragon board (i.MX6ULL) to Linux 6.1 and 
noticed that the connected 1-wire temperature sensors 
(w1_therm.w1_strong_pull=0) sometimes (~ 1 of 20 times) report 85 
degrees Celsius, which is AFAIK the only way to report errors to the 
1-wire master:

sys/bus/w1/devices/28-04168158faff# cat w1_slave
50 05 4b 46 7f ff 0c 10 1c : crc=1c YES
50 05 4b 46 7f ff 0c 10 1c t=85000

I wasn't able to reproduce this issue with the old kernel 4.9.

After that i successfully bisected the issue to this commit:
67b392f7b8ed ("w1_therm: optimizing temperature read timings")

Unfortunately this commit contains a lot of independent changes, which 
makes it hard to figured out the cause of this issue. So i tried to 
split this patch in seven independent changes [1]. Now i was able to 
bisect the cause further to this change [2] which seems to rework the 
pullup handling within read_therm().

Looking closer at the code change and verify it some debug messages, the 
change inverted the locking behavior (before: no pullup -> keep lock, 
after: no pullup -> release lock during sleep).

Before:
	if (external_power) {
		mutex_unlock(&dev_master->bus_mutex);

		sleep_rem = msleep_interruptible(tm);
		if (sleep_rem != 0) {
			ret = -EINTR;
			goto dec_refcnt;
		}

		ret = mutex_lock_interruptible(&dev_master->bus_mutex);
		if (ret != 0)
			goto dec_refcnt;
	} else if (!w1_strong_pullup) {
		sleep_rem = msleep_interruptible(tm);
		if (sleep_rem != 0) {
			ret = -EINTR;
			goto mt_unlock;
		}
	}

After:
	if (strong_pullup) { /*some device need pullup */
		sleep_rem = msleep_interruptible(tm);
		if (sleep_rem != 0) {
			ret = -EINTR;
			goto mt_unlock;
		}
	} else { /*no device need pullup */
		mutex_unlock(&dev_master->bus_mutex);

		sleep_rem = msleep_interruptible(tm);
		if (sleep_rem != 0) {
			ret = -EINTR;
			goto dec_refcnt;
		}

		ret = mutex_lock_interruptible(&dev_master->bus_mutex);
		if (ret != 0)
			goto dec_refcnt;
	}

I don't believe this is intended. After inverting the strong_pullup 
check, the issue wasn't reproducible on our platform anymore. But i'm 
not sure this is clean.

Best regards

#regzbot introduced: 67b392f7b8ed

[1] - https://github.com/chargebyte/linux/commits/v6.1-tarragon_w1
[2] - 
https://github.com/chargebyte/linux/commit/17ca863a32a6a1bdd376959f05c954bef12fc1b5
