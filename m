Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BF966BD2A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjAPLs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjAPLso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:48:44 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1966159D4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:48:43 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id b4so20855877edf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t+52Xcjy623yFxLNIqzxD4LDWhEgZjEXz5cOpFcQDL0=;
        b=QGBGar3Fg6cBUQ6wmJE+ZdahQUZv2znFlo+VULf2vfznVWbw5b9dhrGcHw+VmWfEMn
         X/R51d7xRL/iOWPHQugcltfMR8gtaw1bX//rQHcgYCWWgx6hBuL7PXnMZiOI8FxXp+Is
         GLwU496zeA1f9Pn/R/ony32pA9klEBNeQf1zYcrgc7SJWfEq9aD4nfy/Y4B00QFqgV6c
         iWv1CpEz+yCVdTVgNbguUuJjwMtx6kUQpizqBarNznRc91fl2tSx/XwKS1DYmlz+45DI
         l5LVS8dbE3D3UyTVyYqJoD66Rh8uvy+OrTnEy4pHxRwqEA8l7x4HmjF1KpKYRKjXXmnI
         O5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t+52Xcjy623yFxLNIqzxD4LDWhEgZjEXz5cOpFcQDL0=;
        b=2kyOWz/886oBAEOaSf6U0G55DqKZZYRnKveEBfpkxxf7i5yehigufZXCALwbs8kCZX
         Vhb7q6eRgOoE1fFDqTsjMOd6pUcWoI+oEohKsMn1H5eoR9KubVlP7EueaonwbWoJd0wh
         u5dwzlpBhzMJAveeagkZjC4tyIOQ+UmIX7B1A7T50dgouSnRJSpK7J46DvbhudEBueNv
         IlkfXRhsg1F2RXilu1q+j/4dtlYrCCp7d9YvG+SeqCssV+j1hNK0hGaJr7dtY7ViLY84
         nR2d+uZgJCtADKScKNNd61KsAIca7vOBsQ7fIcd3JWGDDj9Vm1enXP+bDcxyTQzpi8lZ
         HxXA==
X-Gm-Message-State: AFqh2krF1s7/ySwkzHVolJ+Gu9GtDqrI0ywCESPY+C+Q6dIfqN/ZFdoH
        rQJB5AHKAZiNv2jrIC680DH10l5Y6UAS3oloquPSPGUflKA=
X-Google-Smtp-Source: AMrXdXviHmlHTAe2eP4Qgj+odwMmKJj8qu6tZSP1QGIWASz0ynyYHhEGO6bv5HUCM8CfOdB6pN2Lz9hN2p8rBgn+l7E=
X-Received: by 2002:a05:6402:530c:b0:472:9af1:1f72 with SMTP id
 eo12-20020a056402530c00b004729af11f72mr11293862edb.283.1673869721111; Mon, 16
 Jan 2023 03:48:41 -0800 (PST)
MIME-Version: 1.0
From:   Amit <amitchoudhary0523@gmail.com>
Date:   Mon, 16 Jan 2023 17:18:29 +0530
Message-ID: <CAFf+5zjSkGyMXTybY7wioFM9gxruhGfKNKh797vvy29NMWsa4g@mail.gmail.com>
Subject: Alternate implementation of getline() function of standard C library.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alternate implementation of getline() function of standard C library.

---- Start of Code ----

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>

#define NO_ERROR 0 // no error happened.
#define INVALID_FD -1 // fd is less than 0.
#define NO_MEMORY -2 // memory not available.
#define FILE_LSEEK_ERROR -3 // error in seeking file

#define BUF_SIZE_INCREMENT 1024

#define NEW_LINE '\n'

char *get_line_from_file(int fd, int *error_num);

/*
 * char *get_line_from_file(int fd, int *error_num):
 *
 * Function get_line_from_file() returns a line from the file represented by fd.
 *
 * This function supports regular files only (and not pipes, sockets, etc).
 *
 * If fd is less than 0 then NULL is returned and *error_num is assigned the
 * appropriate error value (INVALID_FD in this case).
 *
 * In case of any error, *error_num is assigned the appropriate error value.
 *
 * The high level algorithm of this function is:
 *
 *      The function get_line_from_file() reads some bytes in a buffer from the
 *      file and tries to find newline in the buffer. If a newline is not found
 *      then it reads more bytes from the file in the buffer. When a newline is
 *      found in the buffer, then the newline is replaced with null byte and the
 *      buffer is reallocated to correct size. Then the file offset for reading
 *      is set to the start of the next line. And then the buffer is returned to
 *      the user.
 *
 * Please note that the returned line/buffer doesn't contain any newlines.
 *
 * The line/buffer returned by this function is allocated using realloc(),
 * so it is user's responsibility to free the line (free memory).
 *
 */
char *get_line_from_file(int fd, int *error_num)
{

    char *buf = NULL;
    char *buf_temp = NULL;

    long curr_buf_size = 0;
    long curr_data_len = 0;

    ssize_t bytes_read = -1;
    int end_of_file_reached_or_error = 0;
    int new_line_found = 0;
    long i = 0;

    *error_num = NO_ERROR;

    if (fd < 0) {
        *error_num = INVALID_FD;
        return NULL;
    }

    while (1) {

        buf_temp = realloc(buf, (size_t)(curr_buf_size + BUF_SIZE_INCREMENT));
        if(!buf_temp) {
            *error_num = NO_MEMORY;
            free(buf);
            return NULL;
        }
        buf = buf_temp;
        curr_buf_size = curr_buf_size + BUF_SIZE_INCREMENT;

        // read data from file
        while (curr_data_len != curr_buf_size) {

            bytes_read = read(fd, buf + curr_data_len,
                              (size_t)(curr_buf_size - curr_data_len));

            if (bytes_read == 0) { // end of file reached
                // Check if no bytes were read earlier also in this call to
                // get_line_from_file(). If yes, then this means that end of
                // test file was reached (but not actually read) in the last
                // call to get_line_from_file(). So, this time end of file was
                // read and 0 was returned by read. So, since there are no bytes
                // to process, free the buffer and return NULL.
                if (curr_data_len == 0) {
                    free(buf);
                    return NULL;
                }
            } // end of if bytes_read == 0

            if (bytes_read <= 0) {
                end_of_file_reached_or_error = 1;
                break;
            } // end of if bytes_read <= 0

            curr_data_len = curr_data_len + bytes_read;

        } // end of inner while (1)

        new_line_found = 0;

        for (i = 0; i < curr_data_len; i++) {
            if (buf[i] == NEW_LINE) {
                buf[i] = 0;
                new_line_found = 1;
                break;
            }
        } // end of for loop

        if (new_line_found) {

            // realloc and seek
            buf_temp = realloc(buf, (size_t)(i + 1));
            if(!buf_temp) {
                *error_num = NO_MEMORY;
                free(buf);
                return NULL;
            }

            if (lseek(fd, (i + 1) - curr_data_len, SEEK_CUR) < 0) {
                *error_num = FILE_LSEEK_ERROR;
                free(buf);
                return NULL;
            }
            return buf_temp;

        } else { // new line not found

            // NEW_LINE not found and end of file has been reached or some
            // error happened. So, allocate one extra byte for terminating
            // null byte and return.
            if (end_of_file_reached_or_error) {

                buf_temp = realloc(buf, (size_t)(curr_data_len + 1));
                if(!buf_temp) {
                    *error_num = NO_MEMORY;
                    free(buf);
                    return NULL;
                }
                buf_temp[curr_data_len] = 0;
                return buf_temp;

            } // end of if end_of_file_reached_or_error

        } // end of if - else (new_line_found)

    } // end of outer while (1)

} // end of get_line_from_file

static void print_usage_and_exit(void)
{

    printf("\n");
    printf("Usage: get_line_from_file test_file_name\n");
    printf("\n");
    exit(1);

} // print_usage_and_exit

int main(int argc, char * argv[])
{

    int fd = -1;
    char *line = NULL;
    int error_num = 0;

    if (argc != 2) {
        printf("\nOnly two arguments are required."
               " Program name and test file name.\n");
        print_usage_and_exit();
    }

    fd = open(argv[1], O_RDONLY);
    if (fd < 0) {
        printf("\n%s: File \"%s\" could not be opened. Exiting..\n\n",
               __FILE__, argv[1]);
        exit(1);
    }

    while ((line = get_line_from_file(fd, &error_num)) != NULL) {
        printf("%s\n", line);
        free(line);
    }

    if (error_num != 0) {
        printf("\nError number returned = %d\n\n", error_num);
    }

    close(fd);

} // end of main

---- End of Code ----
