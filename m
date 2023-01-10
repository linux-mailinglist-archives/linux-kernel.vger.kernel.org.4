Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0DE664147
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbjAJNJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238371AbjAJNIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:08:45 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAA861445;
        Tue, 10 Jan 2023 05:08:41 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pFEMk-0006yz-DM; Tue, 10 Jan 2023 14:08:34 +0100
Message-ID: <7cff27f8-d363-bbfb-241e-8d6fc0009c40@leemhuis.info>
Date:   Tue, 10 Jan 2023 14:08:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: ieee80211_handle_wake_tx_queue and dynamic ps regression
Content-Language: en-US, de-DE
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, alexander@wetzel-home.de,
        johannes.berg@intel.com, Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <19015168-c747-17b7-f0ae-9d2ee27d221c@linaro.org>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <19015168-c747-17b7-f0ae-9d2ee27d221c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673356121;9748ed96;
X-HE-SMSGID: 1pFEMk-0006yz-DM
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.01.23 13:35, Bryan O'Donoghue wrote:
> commit a790cc3a4fad75048295571a350b95b87e022a5a
> (wake_tx_queue-broken-23-08-01)
> Author: Alexander Wetzel <alexander@wetzel-home.de>
> Date:   Sun Oct 9 18:30:39 2022 +0200
> 
>     wifi: mac80211: add wake_tx_queue callback to drivers
> 
> is causing a regression with

FWIW, there is another report about a regression caused by that commit here:
https://lore.kernel.org/all/Y6tTLPvsxh%2FIm4Ed@tp440p.steeds.sam/
("WLAN broken on Nokia N900 with v6.2-rc1")

For the rest of this mail:

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

> - CONF_PS = 1
> - CONF_DYNAMIC_PS = 0
> - ieee80211_handle_wake_tx_queue
> 
> In this case we get stuck in a loop similar to this
> 
> // IEEE80211_CONF_CHANGE_PS
> [   17.255480] wcn36xx: wcn36xx_change_ps/312 enable
> [   18.088835] ieee80211_tx_h_dynamic_ps/263 setting
> IEEE80211_QUEUE_STOP_REASON_PS
> [   18.088906] ieee80211_handle_wake_tx_queue/334 entry
> [   18.091505] ieee80211_dynamic_ps_disable_work/2250 calling
> ieee80211_hw_config()
> [   18.095370] ieee80211_handle_wake_tx_queue/338 wake_tx_push_queue
> 
> // IEEE80211_CONF_CHANGE_PS
> [   18.102625] wcn36xx: wcn36xx_change_ps/312 disable
> [   18.107643] wake_tx_push_queue/303 entry
> 
> // txq is stopped here reason == IEEE80211_QUEUE_STOP_REASON_PS
> [   18.107654] wake_tx_push_queue/311 q_stopped bitmask 0x00000002
> IEEE80211_QUEUE_STOP_REASON_PS true
> [   18.107661] wake_tx_push_queue/324 exit
> [   18.107667] ieee80211_handle_wake_tx_queue/342 exit
> [   18.115560] ieee80211_handle_wake_tx_queue/334 entry
> [   18.139937] ieee80211_handle_wake_tx_queue/338 wake_tx_push_queue
> [   18.145163] wake_tx_push_queue/303 entry
> [   18.150016] ieee80211_dynamic_ps_disable_work/2252 completed
> ieee80211_hw_config()
> 
> // now we unset IEEE80211_QUEUE_STOP_REASON_PS but too late
> [   18.151145] wake_tx_push_queue/311 q_stopped bitmask 0x00000002
> IEEE80211_QUEUE_STOP_REASON_PS true
> [   18.155263] ieee80211_dynamic_ps_disable_work/2254 clearing
> IEEE80211_QUEUE_STOP_REASON_PS
> [   18.162531] wake_tx_push_queue/324 exit
> [   18.162548] ieee80211_handle_wake_tx_queue/342 exit
> [   18.183639] ieee80211_dynamic_ps_disable_work/2259 cleared
> IEEE80211_QUEUE_STOP_REASON_PS
> 
> // IEEE80211_CONF_CHANGE_PS runs again
> [   18.215487] wcn36xx: wcn36xx_change_ps/312 enable
> 
> We get stuck in that loop. Packets getting transmitted is a rare event,
> most are dropped.
> 
> I tried this as a fix
> 
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -2245,15 +2245,15 @@ void ieee80211_dynamic_ps_disable_work(struct
> work_struct *work)
>                 container_of(work, struct ieee80211_local,
>                              dynamic_ps_disable_work);
> 
> -       if (local->hw.conf.flags & IEEE80211_CONF_PS) {
> -               local->hw.conf.flags &= ~IEEE80211_CONF_PS;
> -               ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
> -       }
> -
>         ieee80211_wake_queues_by_reason(&local->hw,
>                                         IEEE80211_MAX_QUEUE_MAP,
>                                         IEEE80211_QUEUE_STOP_REASON_PS,
>                                         false);
> +
> +       if (local->hw.conf.flags & IEEE80211_CONF_PS) {
> +               local->hw.conf.flags &= ~IEEE80211_CONF_PS;
> +               ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
> +       }
>  }
> 
> but it only "slightly improves" the situation, the fundamental race
> condition is still there.
> 
> Suggest reverting this change and trying again.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced a790cc3a4fad75
#regzbot title net: wifi: most packets are dropped instead of transmitted
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
